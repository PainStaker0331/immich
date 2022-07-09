import {
  Controller,
  Post,
  UseInterceptors,
  UploadedFiles,
  Body,
  UseGuards,
  Get,
  Param,
  ValidationPipe,
  StreamableFile,
  Query,
  Response,
  Headers,
  Delete,
  Logger,
  HttpCode,
  BadRequestException,
} from '@nestjs/common';
import { JwtAuthGuard } from '../../modules/immich-jwt/guards/jwt-auth.guard';
import { AssetService } from './asset.service';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { assetUploadOption } from '../../config/asset-upload.config';
import { AuthUserDto, GetAuthUser } from '../../decorators/auth-user.decorator';
import { CreateAssetDto } from './dto/create-asset.dto';
import { ServeFileDto } from './dto/serve-file.dto';
import { AssetEntity } from '@app/database/entities/asset.entity';
import { Response as Res } from 'express';
import { BackgroundTaskService } from '../../modules/background-task/background-task.service';
import { DeleteAssetDto } from './dto/delete-asset.dto';
import { SearchAssetDto } from './dto/search-asset.dto';
import { CommunicationGateway } from '../communication/communication.gateway';
import { InjectQueue } from '@nestjs/bull';
import { Queue } from 'bull';
import { IAssetUploadedJob } from '@app/job/index';
import { assetUploadedQueueName } from '@app/job/constants/queue-name.constant';
import { assetUploadedProcessorName } from '@app/job/constants/job-name.constant';
import { CheckDuplicateAssetDto } from './dto/check-duplicate-asset.dto';
import { ApiBearerAuth, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CuratedObjectsResponseDto } from './response-dto/curated-objects-response.dto';
import { CuratedLocationsResponseDto } from './response-dto/curated-locations-response.dto';
import { AssetResponseDto } from './response-dto/asset-response.dto';

@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
@ApiTags('Asset')
@Controller('asset')
export class AssetController {
  constructor(
    private wsCommunicateionGateway: CommunicationGateway,
    private assetService: AssetService,
    private backgroundTaskService: BackgroundTaskService,

    @InjectQueue(assetUploadedQueueName)
    private assetUploadedQueue: Queue<IAssetUploadedJob>,
  ) {}

  @Post('upload')
  @UseInterceptors(
    FileFieldsInterceptor(
      [
        { name: 'assetData', maxCount: 1 },
        { name: 'thumbnailData', maxCount: 1 },
      ],
      assetUploadOption,
    ),
  )
  async uploadFile(
    @GetAuthUser() authUser: AuthUserDto,
    @UploadedFiles() uploadFiles: { assetData: Express.Multer.File[] },
    @Body(ValidationPipe) assetInfo: CreateAssetDto,
  ): Promise<'ok' | undefined> {
    for (const file of uploadFiles.assetData) {
      try {
        const savedAsset = await this.assetService.createUserAsset(authUser, assetInfo, file.path, file.mimetype);

        if (savedAsset) {
          await this.assetUploadedQueue.add(
            assetUploadedProcessorName,
            { asset: savedAsset, fileName: file.originalname, fileSize: file.size },
            { jobId: savedAsset.id },
          );
        }
      } catch (e) {
        Logger.error(`Error uploading file ${e}`);
        throw new BadRequestException(`Error uploading file`, `${e}`);
      }
    }

    return 'ok';
  }

  @Get('/download')
  async downloadFile(
    @GetAuthUser() authUser: AuthUserDto,
    @Response({ passthrough: true }) res: Res,
    @Query(ValidationPipe) query: ServeFileDto,
  ): Promise<StreamableFile> {
    return this.assetService.downloadFile(query, res);
  }

  @Get('/file')
  async serveFile(
    @Headers() headers: Record<string, string>,
    @GetAuthUser() authUser: AuthUserDto,
    @Response({ passthrough: true }) res: Res,
    @Query(ValidationPipe) query: ServeFileDto,
  ): Promise<StreamableFile | undefined> {
    return this.assetService.serveFile(authUser, query, res, headers);
  }

  @Get('/thumbnail/:assetId')
  async getAssetThumbnail(@Param('assetId') assetId: string) {
    return await this.assetService.getAssetThumbnail(assetId);
  }

  @Get('/allObjects')
  async getCuratedObjects(@GetAuthUser() authUser: AuthUserDto): Promise<CuratedObjectsResponseDto[]> {
    return this.assetService.getCuratedObject(authUser);
  }

  @Get('/allLocation')
  async getCuratedLocations(@GetAuthUser() authUser: AuthUserDto): Promise<CuratedLocationsResponseDto[]> {
    return this.assetService.getCuratedLocation(authUser);
  }

  @Get('/searchTerm')
  async getAssetSearchTerms(@GetAuthUser() authUser: AuthUserDto): Promise<String[]> {
    return this.assetService.getAssetSearchTerm(authUser);
  }

  @Post('/search')
  async searchAsset(
    @GetAuthUser() authUser: AuthUserDto,
    @Body(ValidationPipe) searchAssetDto: SearchAssetDto,
  ): Promise<AssetResponseDto[]> {
    return this.assetService.searchAsset(authUser, searchAssetDto);
  }

  /**
   * Get all AssetEntity belong to the user
   */
  @Get('/')
  async getAllAssets(@GetAuthUser() authUser: AuthUserDto): Promise<AssetResponseDto[]> {
    return await this.assetService.getAllAssets(authUser);
  }

  /**
   * Get all asset of a device that are in the database, ID only.
   */
  @Get('/:deviceId')
  async getUserAssetsByDeviceId(@GetAuthUser() authUser: AuthUserDto, @Param('deviceId') deviceId: string) {
    return await this.assetService.getUserAssetsByDeviceId(authUser, deviceId);
  }

  /**
   * Get a single asset's information
   */
  @Get('/assetById/:assetId')
  async getAssetById(
    @GetAuthUser() authUser: AuthUserDto,
    @Param('assetId') assetId: string,
  ): Promise<AssetResponseDto> {
    return await this.assetService.getAssetById(authUser, assetId);
  }

  @Delete('/')
  async deleteAsset(@GetAuthUser() authUser: AuthUserDto, @Body(ValidationPipe) assetIds: DeleteAssetDto) {
    const deleteAssetList: AssetResponseDto[] = [];

    for (const id of assetIds.ids) {
      const assets = await this.assetService.getAssetById(authUser, id);
      if (!assets) {
        continue;
      }
      deleteAssetList.push(assets);
    }

    const result = await this.assetService.deleteAssetById(authUser, assetIds);

    result.forEach((res) => {
      deleteAssetList.filter((a) => a.id == res.id && res.status == 'success');
    });

    await this.backgroundTaskService.deleteFileOnDisk(deleteAssetList);

    return result;
  }

  /**
   * Check duplicated asset before uploading - for Web upload used
   */
  @Post('/check')
  @HttpCode(200)
  async checkDuplicateAsset(
    @GetAuthUser() authUser: AuthUserDto,
    @Body(ValidationPipe) checkDuplicateAssetDto: CheckDuplicateAssetDto,
  ) {
    const res = await this.assetService.checkDuplicatedAsset(authUser, checkDuplicateAssetDto);

    return {
      isExist: res,
    };
  }
}

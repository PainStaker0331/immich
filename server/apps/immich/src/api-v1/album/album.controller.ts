import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  ValidationPipe,
  ParseUUIDPipe,
  Put,
  Query,
} from '@nestjs/common';
import { ParseMeUUIDPipe } from '../validation/parse-me-uuid-pipe';
import { AlbumService } from './album.service';
import { CreateAlbumDto } from './dto/create-album.dto';
import { JwtAuthGuard } from '../../modules/immich-jwt/guards/jwt-auth.guard';
import { AuthUserDto, GetAuthUser } from '../../decorators/auth-user.decorator';
import { AddAssetsDto } from './dto/add-assets.dto';
import { AddUsersDto } from './dto/add-users.dto';
import { RemoveAssetsDto } from './dto/remove-assets.dto';
import { UpdateAlbumDto } from './dto/update-album.dto';
import { GetAlbumsDto } from './dto/get-albums.dto';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { AlbumResponseDto } from './response-dto/album-response.dto';

// TODO might be worth creating a AlbumParamsDto that validates `albumId` instead of using the pipe.
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
@ApiTags('Album')
@Controller('album')
export class AlbumController {
  constructor(private readonly albumService: AlbumService) {}

  @Post()
  async createAlbum(@GetAuthUser() authUser: AuthUserDto, @Body(ValidationPipe) createAlbumDto: CreateAlbumDto) {
    return this.albumService.create(authUser, createAlbumDto);
  }

  @Put('/:albumId/users')
  async addUsersToAlbum(
    @GetAuthUser() authUser: AuthUserDto,
    @Body(ValidationPipe) addUsersDto: AddUsersDto,
    @Param('albumId', new ParseUUIDPipe({ version: '4' })) albumId: string,
  ) {
    return this.albumService.addUsersToAlbum(authUser, addUsersDto, albumId);
  }

  @Put('/:albumId/assets')
  async addAssetsToAlbum(
    @GetAuthUser() authUser: AuthUserDto,
    @Body(ValidationPipe) addAssetsDto: AddAssetsDto,
    @Param('albumId', new ParseUUIDPipe({ version: '4' })) albumId: string,
  ) {
    return this.albumService.addAssetsToAlbum(authUser, addAssetsDto, albumId);
  }

  @Get()
  async getAllAlbums(
    @GetAuthUser() authUser: AuthUserDto,
    @Query(new ValidationPipe({ transform: true })) query: GetAlbumsDto,
  ) {
    return this.albumService.getAllAlbums(authUser, query);
  }

  @Get('/:albumId')
  async getAlbumInfo(
    @GetAuthUser() authUser: AuthUserDto,
    @Param('albumId', new ParseUUIDPipe({ version: '4' })) albumId: string,
  ) {
    return this.albumService.getAlbumInfo(authUser, albumId);
  }

  @Delete('/:albumId/assets')
  async removeAssetFromAlbum(
    @GetAuthUser() authUser: AuthUserDto,
    @Body(ValidationPipe) removeAssetsDto: RemoveAssetsDto,
    @Param('albumId', new ParseUUIDPipe({ version: '4' })) albumId: string,
  ): Promise<AlbumResponseDto> {
    return this.albumService.removeAssetsFromAlbum(authUser, removeAssetsDto, albumId);
  }

  @Delete('/:albumId')
  async deleteAlbum(
    @GetAuthUser() authUser: AuthUserDto,
    @Param('albumId', new ParseUUIDPipe({ version: '4' })) albumId: string,
  ) {
    return this.albumService.deleteAlbum(authUser, albumId);
  }

  @Delete('/:albumId/user/:userId')
  async removeUserFromAlbum(
    @GetAuthUser() authUser: AuthUserDto,
    @Param('albumId', new ParseUUIDPipe({ version: '4' })) albumId: string,
    @Param('userId', new ParseMeUUIDPipe({ version: '4' })) userId: string,
  ) {
    return this.albumService.removeUserFromAlbum(authUser, albumId, userId);
  }

  @Patch('/:albumId')
  async updateAlbumInfo(
    @GetAuthUser() authUser: AuthUserDto,
    @Body(ValidationPipe) updateAlbumInfoDto: UpdateAlbumDto,
    @Param('albumId', new ParseUUIDPipe({ version: '4' })) albumId: string,
  ) {
    return this.albumService.updateAlbumInfo(authUser, updateAlbumInfoDto, albumId);
  }
}

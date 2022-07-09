import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  UseGuards,
  ValidationPipe,
  Put,
  Query,
  UseInterceptors,
  UploadedFile,
  Response,
  StreamableFile,
} from '@nestjs/common';
import { UserService } from './user.service';
import { JwtAuthGuard } from '../../modules/immich-jwt/guards/jwt-auth.guard';
import { AuthUserDto, GetAuthUser } from '../../decorators/auth-user.decorator';
import { CreateUserDto } from './dto/create-user.dto';
import { AdminRolesGuard } from '../../middlewares/admin-role-guard.middleware';
import { UpdateUserDto } from './dto/update-user.dto';
import { FileInterceptor } from '@nestjs/platform-express';
import { profileImageUploadOption } from '../../config/profile-image-upload.config';
import { Response as Res } from 'express';
import { ApiBearerAuth, ApiBody, ApiConsumes, ApiTags } from '@nestjs/swagger';
import { UserResponseDto } from './response-dto/user-response.dto';
import { UserEntity } from '@app/database/entities/user.entity';
import { UserCountResponseDto } from './response-dto/user-count-response.dto';
import { CreateProfileImageDto } from './dto/create-profile-image.dto';
import { CreateProfileImageResponseDto } from './response-dto/create-profile-image-response.dto';

@ApiTags('User')
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Get()
  async getAllUsers(@GetAuthUser() authUser: AuthUserDto, @Query('isAll') isAll: boolean): Promise<UserResponseDto[]> {
    return await this.userService.getAllUsers(authUser, isAll);
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Get('me')
  async getMyUserInfo(@GetAuthUser() authUser: AuthUserDto): Promise<UserResponseDto> {
    return await this.userService.getUserInfo(authUser);
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @UseGuards(AdminRolesGuard)
  @Post()
  async createUser(@Body(ValidationPipe) createUserDto: CreateUserDto): Promise<UserResponseDto> {
    return await this.userService.createUser(createUserDto);
  }

  @Get('/count')
  async getUserCount(@Query('isAdmin') isAdmin: boolean): Promise<UserCountResponseDto> {
    return await this.userService.getUserCount(isAdmin);
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Put()
  async updateUser(@Body(ValidationPipe) updateUserDto: UpdateUserDto): Promise<UserResponseDto> {
    return await this.userService.updateUser(updateUserDto);
  }

  @UseInterceptors(FileInterceptor('file', profileImageUploadOption))
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    type: CreateProfileImageDto,
  })
  @Post('/profile-image')
  async createProfileImage(
    @GetAuthUser() authUser: AuthUserDto,
    @UploadedFile() fileInfo: Express.Multer.File,
  ): Promise<CreateProfileImageResponseDto> {
    return await this.userService.createProfileImage(authUser, fileInfo);
  }

  @Get('/profile-image/:userId')
  async getProfileImage(
    @Param('userId') userId: string,
    @Response({ passthrough: true }) res: Res,
  ): Promise<StreamableFile | undefined> {
    return this.userService.getUserProfileImage(userId, res);
  }
}

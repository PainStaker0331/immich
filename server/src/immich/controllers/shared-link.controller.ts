import { AuthUserDto, EditSharedLinkDto, SharedLinkResponseDto, SharedLinkService } from '@app/domain';
import { Body, Controller, Delete, Get, Param, Patch } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { GetAuthUser } from '../decorators/auth-user.decorator';
import { Authenticated, SharedLinkRoute } from '../decorators/authenticated.decorator';
import { UseValidation } from '../decorators/use-validation.decorator';
import { UUIDParamDto } from './dto/uuid-param.dto';

@ApiTags('share')
@Controller('share')
@Authenticated()
@UseValidation()
export class SharedLinkController {
  constructor(private readonly service: SharedLinkService) {}

  @Get()
  getAllSharedLinks(@GetAuthUser() authUser: AuthUserDto): Promise<SharedLinkResponseDto[]> {
    return this.service.getAll(authUser);
  }

  @SharedLinkRoute()
  @Get('me')
  getMySharedLink(@GetAuthUser() authUser: AuthUserDto): Promise<SharedLinkResponseDto> {
    return this.service.getMine(authUser);
  }

  @Get(':id')
  getSharedLinkById(
    @GetAuthUser() authUser: AuthUserDto,
    @Param() { id }: UUIDParamDto,
  ): Promise<SharedLinkResponseDto> {
    return this.service.get(authUser, id);
  }

  @Patch(':id')
  updateSharedLink(
    @GetAuthUser() authUser: AuthUserDto,
    @Param() { id }: UUIDParamDto,
    @Body() dto: EditSharedLinkDto,
  ): Promise<SharedLinkResponseDto> {
    return this.service.update(authUser, id, dto);
  }

  @Delete(':id')
  removeSharedLink(@GetAuthUser() authUser: AuthUserDto, @Param() { id }: UUIDParamDto): Promise<void> {
    return this.service.remove(authUser, id);
  }
}

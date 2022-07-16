import { Controller, Get, UseGuards } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtAuthGuard } from '../../modules/immich-jwt/guards/jwt-auth.guard';
import { ServerInfoService } from './server-info.service';
import { serverVersion } from '../../constants/server_version.constant';
import { ApiTags } from '@nestjs/swagger';
import { ServerPingResponse } from './response-dto/server-ping-response.dto';
import { ServerVersionReponseDto } from './response-dto/server-version-response.dto';
import { ServerInfoResponseDto } from './response-dto/server-info-response.dto';
import { DataSource } from 'typeorm';

@ApiTags('Server Info')
@Controller('server-info')
export class ServerInfoController {
  constructor(private readonly serverInfoService: ServerInfoService) {}

  @Get()
  async getServerInfo(): Promise<ServerInfoResponseDto> {
    return await this.serverInfoService.getServerInfo();
  }

  @Get('/ping')
  async pingServer(): Promise<ServerPingResponse> {
    return new ServerPingResponse('pong');
  }

  @Get('/version')
  async getServerVersion(): Promise<ServerVersionReponseDto> {
    return serverVersion;
  }
}

import { SystemConfig } from '@app/infra/db/entities';
import {
  BadRequestException,
  Inject,
  Injectable,
  InternalServerErrorException,
  Logger,
  UnauthorizedException,
} from '@nestjs/common';
import * as cookieParser from 'cookie';
import { IncomingHttpHeaders } from 'http';
import { Socket } from 'socket.io';
import { OAuthCore } from '../oauth/oauth.core';
import { INITIAL_SYSTEM_CONFIG, ISystemConfigRepository } from '../system-config';
import { IUserRepository, UserCore, UserResponseDto } from '../user';
import { AuthType, jwtSecret } from './auth.constant';
import { AuthCore } from './auth.core';
import { ICryptoRepository } from './crypto.repository';
import { AuthUserDto, ChangePasswordDto, JwtPayloadDto, LoginCredentialDto, SignUpDto } from './dto';
import { AdminSignupResponseDto, LoginResponseDto, LogoutResponseDto, mapAdminSignupResponse } from './response-dto';

@Injectable()
export class AuthService {
  private authCore: AuthCore;
  private oauthCore: OAuthCore;
  private userCore: UserCore;

  private logger = new Logger(AuthService.name);

  constructor(
    @Inject(ICryptoRepository) private cryptoRepository: ICryptoRepository,
    @Inject(ISystemConfigRepository) configRepository: ISystemConfigRepository,
    @Inject(IUserRepository) userRepository: IUserRepository,
    @Inject(INITIAL_SYSTEM_CONFIG) initialConfig: SystemConfig,
  ) {
    this.authCore = new AuthCore(cryptoRepository, configRepository, initialConfig);
    this.oauthCore = new OAuthCore(configRepository, initialConfig);
    this.userCore = new UserCore(userRepository);
  }

  public async login(
    loginCredential: LoginCredentialDto,
    clientIp: string,
    isSecure: boolean,
  ): Promise<{ response: LoginResponseDto; cookie: string[] }> {
    if (!this.authCore.isPasswordLoginEnabled()) {
      throw new UnauthorizedException('Password login has been disabled');
    }

    let user = await this.userCore.getByEmail(loginCredential.email, true);
    if (user) {
      const isAuthenticated = await this.authCore.validatePassword(loginCredential.password, user);
      if (!isAuthenticated) {
        user = null;
      }
    }

    if (!user) {
      this.logger.warn(`Failed login attempt for user ${loginCredential.email} from ip address ${clientIp}`);
      throw new BadRequestException('Incorrect email or password');
    }

    return this.authCore.createLoginResponse(user, AuthType.PASSWORD, isSecure);
  }

  public async logout(authType: AuthType): Promise<LogoutResponseDto> {
    if (authType === AuthType.OAUTH) {
      const url = await this.oauthCore.getLogoutEndpoint();
      if (url) {
        return { successful: true, redirectUri: url };
      }
    }

    return { successful: true, redirectUri: '/auth/login?autoLaunch=0' };
  }

  public async changePassword(authUser: AuthUserDto, dto: ChangePasswordDto) {
    const { password, newPassword } = dto;
    const user = await this.userCore.getByEmail(authUser.email, true);
    if (!user) {
      throw new UnauthorizedException();
    }

    const valid = await this.authCore.validatePassword(password, user);
    if (!valid) {
      throw new BadRequestException('Wrong password');
    }

    return this.userCore.updateUser(authUser, authUser.id, { password: newPassword });
  }

  public async adminSignUp(dto: SignUpDto): Promise<AdminSignupResponseDto> {
    const adminUser = await this.userCore.getAdmin();

    if (adminUser) {
      throw new BadRequestException('The server already has an admin');
    }

    try {
      const admin = await this.userCore.createUser({
        isAdmin: true,
        email: dto.email,
        firstName: dto.firstName,
        lastName: dto.lastName,
        password: dto.password,
      });

      return mapAdminSignupResponse(admin);
    } catch (error) {
      this.logger.error(`Unable to register admin user: ${error}`, (error as Error).stack);
      throw new InternalServerErrorException('Failed to register new admin user');
    }
  }

  async validateSocket(client: Socket): Promise<UserResponseDto | null> {
    try {
      const headers = client.handshake.headers;
      const accessToken =
        this.extractJwtFromCookie(cookieParser.parse(headers.cookie || '')) || this.extractJwtFromHeader(headers);

      if (accessToken) {
        const payload = await this.cryptoRepository.verifyJwtAsync<JwtPayloadDto>(accessToken, { secret: jwtSecret });
        if (payload?.userId && payload?.email) {
          const user = await this.userCore.get(payload.userId);
          if (user) {
            return user;
          }
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  async validatePayload(payload: JwtPayloadDto) {
    const { userId } = payload;
    const user = await this.userCore.get(userId);
    if (!user) {
      throw new UnauthorizedException('Failure to validate JWT payload');
    }

    const authUser = new AuthUserDto();
    authUser.id = user.id;
    authUser.email = user.email;
    authUser.isAdmin = user.isAdmin;
    authUser.isPublicUser = false;
    authUser.isAllowUpload = true;

    return authUser;
  }

  extractJwtFromCookie(cookies: Record<string, string>) {
    return this.authCore.extractJwtFromCookie(cookies);
  }

  extractJwtFromHeader(headers: IncomingHttpHeaders) {
    return this.authCore.extractJwtFromHeader(headers);
  }
}

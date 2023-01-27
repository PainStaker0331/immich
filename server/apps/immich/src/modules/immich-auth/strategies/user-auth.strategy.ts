import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { AuthService, AuthUserDto, UserService } from '@app/domain';
import { Strategy } from 'passport-custom';
import { Request } from 'express';

export const AUTH_COOKIE_STRATEGY = 'auth-cookie';

@Injectable()
export class UserAuthStrategy extends PassportStrategy(Strategy, AUTH_COOKIE_STRATEGY) {
  constructor(private userService: UserService, private authService: AuthService) {
    super();
  }

  async validate(request: Request): Promise<AuthUserDto> {
    const authUser = await this.authService.validate(request.headers);

    if (!authUser) {
      throw new UnauthorizedException('Incorrect token provided');
    }

    return authUser;
  }
}

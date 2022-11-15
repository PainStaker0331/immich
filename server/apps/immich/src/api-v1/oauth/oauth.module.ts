import { Module } from '@nestjs/common';
import { ImmichJwtModule } from '../../modules/immich-jwt/immich-jwt.module';
import { UserModule } from '../user/user.module';
import { OAuthController } from './oauth.controller';
import { OAuthService } from './oauth.service';

@Module({
  imports: [UserModule, ImmichJwtModule],
  controllers: [OAuthController],
  providers: [OAuthService],
  exports: [OAuthService],
})
export class OAuthModule {}

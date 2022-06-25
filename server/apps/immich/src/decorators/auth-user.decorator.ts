import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { UserEntity } from '@app/database/entities/user.entity';
// import { AuthUserDto } from './dto/auth-user.dto';

export class AuthUserDto {
  id!: string;
  email!: string;
}

export const GetAuthUser = createParamDecorator((data, ctx: ExecutionContext): AuthUserDto => {
  const req = ctx.switchToHttp().getRequest<{ user: UserEntity }>();

  const { id, email } = req.user;

  const authUser: AuthUserDto = {
    id: id.toString(),
    email,
  };

  return authUser;
});

import { UserEntity } from '@app/infra/entities';

export class UserResponseDto {
  id!: string;
  email!: string;
  firstName!: string;
  lastName!: string;
  storageLabel!: string | null;
  externalPath!: string | null;
  profileImagePath!: string;
  shouldChangePassword!: boolean;
  isAdmin!: boolean;
  createdAt!: Date;
  deletedAt!: Date | null;
  updatedAt!: Date;
  oauthId!: string;
  memoriesEnabled?: boolean;
}

export function mapUser(entity: UserEntity): UserResponseDto {
  return {
    id: entity.id,
    email: entity.email,
    firstName: entity.firstName,
    lastName: entity.lastName,
    storageLabel: entity.storageLabel,
    externalPath: entity.externalPath,
    profileImagePath: entity.profileImagePath,
    shouldChangePassword: entity.shouldChangePassword,
    isAdmin: entity.isAdmin,
    createdAt: entity.createdAt,
    deletedAt: entity.deletedAt,
    updatedAt: entity.updatedAt,
    oauthId: entity.oauthId,
    memoriesEnabled: entity.memoriesEnabled,
  };
}

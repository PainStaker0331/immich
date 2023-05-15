import { PartnerEntity } from '@app/infra/entities';

export interface PartnerIds {
  sharedById: string;
  sharedWithId: string;
}

export const IPartnerRepository = 'IPartnerRepository';

export interface IPartnerRepository {
  getAll(userId: string): Promise<PartnerEntity[]>;
  get(partner: PartnerIds): Promise<PartnerEntity | null>;
  create(partner: PartnerIds): Promise<PartnerEntity>;
  remove(entity: PartnerEntity): Promise<void>;
  hasAssetAccess(assetId: string, userId: string): Promise<boolean>;
}

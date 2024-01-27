import { Column, Entity, JoinColumn, OneToMany, OneToOne, PrimaryGeneratedColumn } from 'typeorm';
import { AssetEntity } from './asset.entity';

@Entity('asset_stack')
export class AssetStackEntity {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @OneToMany(() => AssetEntity, (asset) => asset.stack)
  assets!: AssetEntity[];

  @OneToOne(() => AssetEntity)
  @JoinColumn()
  //TODO: Add constraint to ensure primary asset exists in the assets array
  primaryAsset!: AssetEntity;

  @Column({ nullable: false })
  primaryAssetId!: string;
}

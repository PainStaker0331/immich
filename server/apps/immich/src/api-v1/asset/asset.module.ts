import { Module } from '@nestjs/common';
import { AssetService } from './asset.service';
import { AssetController } from './asset.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AssetEntity } from '@app/database/entities/asset.entity';
import { BullModule } from '@nestjs/bull';
import { BackgroundTaskModule } from '../../modules/background-task/background-task.module';
import { BackgroundTaskService } from '../../modules/background-task/background-task.service';
import { CommunicationModule } from '../communication/communication.module';
import { assetUploadedQueueName } from '@app/job/constants/queue-name.constant';

@Module({
  imports: [
    CommunicationModule,
    BackgroundTaskModule,
    TypeOrmModule.forFeature([AssetEntity]),
    BullModule.registerQueue({
      name: assetUploadedQueueName,
      defaultJobOptions: {
        attempts: 3,
        removeOnComplete: true,
        removeOnFail: false,
      },
    }),
  ],
  controllers: [AssetController],
  providers: [AssetService, BackgroundTaskService],
  exports: [AssetService],
})
export class AssetModule {}

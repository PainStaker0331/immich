import { mp4ConversionProcessorName } from '@app/job/constants/job-name.constant';
import { videoConversionQueueName } from '@app/job/constants/queue-name.constant';
import { IMp4ConversionProcessor } from '@app/job/interfaces/video-transcode.interface';
import { Process, Processor } from '@nestjs/bull';
import { Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Job } from 'bull';
import ffmpeg from 'fluent-ffmpeg';
import { existsSync, mkdirSync } from 'fs';
import { Repository } from 'typeorm';
import { AssetEntity } from '../../../../libs/database/src/entities/asset.entity';
import { APP_UPLOAD_LOCATION } from '../../../immich/src/constants/upload_location.constant';

@Processor(videoConversionQueueName)
export class VideoTranscodeProcessor {
  constructor(
    @InjectRepository(AssetEntity)
    private assetRepository: Repository<AssetEntity>,
  ) {}

  @Process({ name: mp4ConversionProcessorName, concurrency: 1 })
  async mp4Conversion(job: Job<IMp4ConversionProcessor>) {
    const { asset } = job.data;

    if (asset.mimeType != 'video/mp4') {
      const basePath = APP_UPLOAD_LOCATION;
      const encodedVideoPath = `${basePath}/${asset.userId}/encoded-video`;

      if (!existsSync(encodedVideoPath)) {
        mkdirSync(encodedVideoPath, { recursive: true });
      }

      const savedEncodedPath = encodedVideoPath + '/' + asset.id + '.mp4';

      if (asset.encodedVideoPath == '' || !asset.encodedVideoPath) {
        // Put the processing into its own async function to prevent the job exist right away
        await this.runFFMPEGPipeLine(asset, savedEncodedPath);
      }
    }
  }

  async runFFMPEGPipeLine(asset: AssetEntity, savedEncodedPath: string): Promise<void> {
    return new Promise((resolve, reject) => {
      ffmpeg(asset.originalPath)
        .outputOptions(['-crf 23', '-preset ultrafast', '-vcodec libx264', '-acodec mp3', '-vf scale=1280:-2'])
        .output(savedEncodedPath)
        .on('start', () => {
          Logger.log('Start Converting Video', 'mp4Conversion');
        })
        .on('error', (error) => {
          Logger.error(`Cannot Convert Video ${error}`, 'mp4Conversion');
          reject();
        })
        .on('end', async () => {
          Logger.log(`Converting Success ${asset.id}`, 'mp4Conversion');
          await this.assetRepository.update({ id: asset.id }, { encodedVideoPath: savedEncodedPath });
          resolve();
        })
        .run();
    });
  }
}

import { ISystemConfigRepository } from '../system-config';
import {
  supportedDayTokens,
  supportedHourTokens,
  supportedMinuteTokens,
  supportedMonthTokens,
  supportedPresetTokens,
  supportedSecondTokens,
  supportedYearTokens,
} from './system-config.constants';
import { Inject, Injectable } from '@nestjs/common';
import { IJobRepository, JobName } from '../job';
import { mapConfig, SystemConfigDto } from './dto/system-config.dto';
import { SystemConfigTemplateStorageOptionDto } from './response-dto/system-config-template-storage-option.dto';
import { SystemConfigCore, SystemConfigValidator } from './system-config.core';

@Injectable()
export class SystemConfigService {
  private core: SystemConfigCore;
  constructor(
    @Inject(ISystemConfigRepository) repository: ISystemConfigRepository,
    @Inject(IJobRepository) private queue: IJobRepository,
  ) {
    this.core = new SystemConfigCore(repository);
  }

  get config$() {
    return this.core.config$;
  }

  async getConfig(): Promise<SystemConfigDto> {
    const config = await this.core.getConfig();
    return mapConfig(config);
  }

  getDefaults(): SystemConfigDto {
    const config = this.core.getDefaults();
    return mapConfig(config);
  }

  async updateConfig(dto: SystemConfigDto): Promise<SystemConfigDto> {
    const config = await this.core.updateConfig(dto);
    await this.queue.add({ name: JobName.CONFIG_CHANGE });
    return mapConfig(config);
  }

  async refreshConfig() {
    await this.core.refreshConfig();
  }

  addValidator(validator: SystemConfigValidator) {
    this.core.addValidator(validator);
  }

  getStorageTemplateOptions(): SystemConfigTemplateStorageOptionDto {
    const options = new SystemConfigTemplateStorageOptionDto();

    options.dayOptions = supportedDayTokens;
    options.monthOptions = supportedMonthTokens;
    options.yearOptions = supportedYearTokens;
    options.hourOptions = supportedHourTokens;
    options.secondOptions = supportedSecondTokens;
    options.minuteOptions = supportedMinuteTokens;
    options.presetOptions = supportedPresetTokens;

    return options;
  }
}

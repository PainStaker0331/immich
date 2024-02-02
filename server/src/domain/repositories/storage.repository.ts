import { FSWatcher, WatchOptions } from 'chokidar';
import { Stats } from 'node:fs';
import { FileReadOptions } from 'node:fs/promises';
import { Readable } from 'node:stream';
import { CrawlOptionsDto } from '../library';

export interface ImmichReadStream {
  stream: Readable;
  type?: string;
  length?: number;
}

export interface ImmichZipStream extends ImmichReadStream {
  addFile: (inputPath: string, filename: string) => void;
  finalize: () => Promise<void>;
}

export interface DiskUsage {
  available: number;
  free: number;
  total: number;
}

export const IStorageRepository = 'IStorageRepository';

export interface ImmichWatcher extends FSWatcher {}

export interface IStorageRepository {
  createZipStream(): ImmichZipStream;
  createReadStream(filepath: string, mimeType?: string | null): Promise<ImmichReadStream>;
  readFile(filepath: string, options?: FileReadOptions<Buffer>): Promise<Buffer>;
  writeFile(filepath: string, buffer: Buffer): Promise<void>;
  unlink(filepath: string): Promise<void>;
  unlinkDir(folder: string, options?: { recursive?: boolean; force?: boolean }): Promise<void>;
  removeEmptyDirs(folder: string, self?: boolean): Promise<void>;
  checkFileExists(filepath: string, mode?: number): Promise<boolean>;
  mkdirSync(filepath: string): void;
  checkDiskUsage(folder: string): Promise<DiskUsage>;
  readdir(folder: string): Promise<string[]>;
  stat(filepath: string): Promise<Stats>;
  crawl(crawlOptions: CrawlOptionsDto): Promise<string[]>;
  copyFile(source: string, target: string): Promise<void>;
  rename(source: string, target: string): Promise<void>;
  watch(paths: string[], options: WatchOptions): ImmichWatcher;
}

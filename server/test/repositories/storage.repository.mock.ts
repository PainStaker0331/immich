import { IStorageRepository, StorageCore, WatchEvents } from '@app/domain';
import { WatchOptions } from 'chokidar';

interface MockWatcherOptions {
  items?: Array<{ event: 'change' | 'add' | 'unlink' | 'error'; value: string }>;
  close?: () => void;
}

export const makeMockWatcher =
  ({ items, close }: MockWatcherOptions) =>
  (paths: string[], options: WatchOptions, events: Partial<WatchEvents>) => {
    events.onReady?.();
    for (const item of items || []) {
      switch (item.event) {
        case 'add': {
          events.onAdd?.(item.value);
          break;
        }
        case 'change': {
          events.onChange?.(item.value);
          break;
        }
        case 'unlink': {
          events.onUnlink?.(item.value);
          break;
        }
        case 'error': {
          events.onError?.(new Error(item.value));
        }
      }
    }
    return () => close?.();
  };

export const newStorageRepositoryMock = (reset = true): jest.Mocked<IStorageRepository> => {
  if (reset) {
    StorageCore.reset();
  }

  return {
    createZipStream: jest.fn(),
    createReadStream: jest.fn(),
    readFile: jest.fn(),
    writeFile: jest.fn(),
    unlink: jest.fn(),
    unlinkDir: jest.fn().mockResolvedValue(true),
    removeEmptyDirs: jest.fn(),
    checkFileExists: jest.fn(),
    mkdirSync: jest.fn(),
    checkDiskUsage: jest.fn(),
    readdir: jest.fn(),
    stat: jest.fn(),
    crawl: jest.fn(),
    rename: jest.fn(),
    copyFile: jest.fn(),
    utimes: jest.fn(),
    watch: jest.fn().mockImplementation(makeMockWatcher({})),
  };
};

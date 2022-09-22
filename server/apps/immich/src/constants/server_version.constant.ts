// major.minor.patch+build
// check mobile/pubspec.yml for current release version

export interface IServerVersion {
  major: number;
  minor: number;
  patch: number;
  build: number;
}

export const serverVersion: IServerVersion = {
  major: 1,
  minor: 29,
  patch: 5,
  build: 44,
};

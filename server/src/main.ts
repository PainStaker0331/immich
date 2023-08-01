import { bootstrap as adminCli } from './admin-cli/main';
import { bootstrap as immich } from './immich/main';
import { bootstrap as microservices } from './microservices/main';

const immichApp = process.argv[2] || process.env.IMMICH_APP;

if (process.argv[2] === immichApp) {
  process.argv.splice(2, 1);
}

function bootstrap() {
  switch (immichApp) {
    case 'immich':
      return immich();
    case 'microservices':
      return microservices();
    case 'admin-cli':
      return adminCli();
    default:
      console.log(`Invalid app name: ${immichApp}. Expected one of immich|microservices|cli`);
      process.exit(1);
  }
}
bootstrap();

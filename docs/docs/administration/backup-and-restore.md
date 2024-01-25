# Backup and Restore

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

A [3-2-1 backup strategy](https://www.backblaze.com/blog/the-3-2-1-backup-strategy/) is recommended to protect your data. You should keep copies of your uploaded photos/videos as well as the Immich database for a comprehensive backup solution. This page provides an overview on how to backup the database and the location of user-uploaded pictures and videos. A template bash script that can be run as a cron job is provided [here](/docs/guides/template-backup-script.md)

## Database

:::caution
Immich saves [file paths in the database](https://github.com/immich-app/immich/discussions/3299), it does not scan the library folder to update the database so backups are crucial.
:::

:::info
Refer to the official [postgres documentation](https://www.postgresql.org/docs/current/backup.html) for details about backing up and restoring a postgres database.
:::

The recommended way to backup and restore the Immich database is to use the `pg_dumpall` command.

<Tabs>
  <TabItem value="Linux system based Backup" label="Linux system based Backup" default>

```bash title='Bash'
docker exec -t immich_postgres pg_dumpall -c -U postgres | gzip > "/path/to/backup/dump.sql.gz"
```

```bash title='Restore'
docker compose down -v  # CAUTION! Deletes all Immich data to start from scratch.
docker compose pull     # Update to latest version of Immich (if desired)
docker compose create   # Create Docker containers for Immich apps without running them.
docker start immich_postgres    # Start Postgres server
sleep 10    # Wait for Postgres server to start up
gunzip < "/path/to/backup/dump.sql.gz" | docker exec -i immich_postgres psql -U postgres -d immich    # Restore Backup
docker compose up -d    # Start remainder of Immich apps
```

</TabItem>
  <TabItem value="Windows system based Backup" label="Windows system based Backup">

```powershell title='Backup'
docker exec -t immich_postgres pg_dumpall -c -U postgres > "\path\to\backup\dump.sql"
```

```powershell title='Restore'
docker compose down -v  # CAUTION! Deletes all Immich data to start from scratch.
docker compose pull     # Update to latest version of Immich (if desired)
docker compose create   # Create Docker containers for Immich apps without running them.
docker start immich_postgres    # Start Postgres server
sleep 10    # Wait for Postgres server to start up
gc "C:\path\to\backup\dump.sql" | docker exec -i immich_postgres psql -U postgres -d immich    # Restore Backup
docker compose up -d    # Start remainder of Immich apps
```

</TabItem>
</Tabs>

Note that for the database restore to proceed properly, it requires a completely fresh install (i.e. the Immich server has never run since creating the Docker containers). If the Immich app has run, Postgres conflicts may be encountered upon database restoration (relation already exists, violated foreign key constraints, multiple primary keys, etc.).

The database dumps can also be automated (using [this image](https://github.com/prodrigestivill/docker-postgres-backup-local)) by editing the docker compose file to match the following:

```yaml
services:
  ...
  backup:
    container_name: immich_db_dumper
    image: prodrigestivill/postgres-backup-local
    env_file:
      - .env
    environment:
      POSTGRES_HOST: database
      POSTGRES_DB: ${DB_DATABASE_NAME}
      POSTGRES_USER: ${DB_USERNAME}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      SCHEDULE: "@daily"
      BACKUP_DIR: /db_dumps
    volumes:
      - ./db_dumps:/db_dumps
    depends_on:
      - database
```

Then you can restore with the same command but pointed at the latest dump.

```bash title='Automated Restore'
gunzip < db_dumps/last/immich-latest.sql.gz | docker exec -i immich_postgres psql -U postgres -d immich
```

## Filesystem

Immich stores two types of content in the filesystem: (1) original, unmodified content, and (2) generated content. Only the original content needs to be backed-up, which includes the following folders:

1. `UPLOAD_LOCATION/library`
2. `UPLOAD_LOCATION/upload`
3. `UPLOAD_LOCATION/profile`

### Asset Types and Storage Locations

Some storage locations are impacted by the Storage Template. See below for more details.

<Tabs>
  <TabItem value="Storage Template Off (Default)." label="Storage Template Off (Default)." default>

:::note
`UPLOAD_LOCATION/library` folder is not used by default on new machines running version 1.92.0. These are if the system administrator activated the storage template engine, for [more info](https://github.com/immich-app/immich/releases#:~:text=the%20partner%E2%80%99s%20assets.-,Hardening%20storage%20template,-We%20have%20further).
:::

**1. User-Specific Folders:**

- Each user has a unique string representing them.
- You can find your user ID in Account Account Settings -> Account -> User ID.

**2. Asset Types and Storage Locations:**

- **Source Assets:**
  - Original assets uploaded through the browser interface & mobile & CLI.
  - Stored in `/library/upload/<userID>`.
- **Avatar Images:**
  - User profile images.
  - Stored in `/library/profile/<userID>`.
- **Thumbs Images:**
  - Preview images (blurred, small, large) for each asset and thumbnails for recognized faces.
  - Stored in `/library/thumbs/<userID>`.
- **Encoded Assets:**
  - By default, unless otherwise specified re-encoded video assets for wider compatibility.
  - Stored in `/library/encoded-video/<userID>`.

</TabItem>
  <TabItem value="Storage Template On" label="Storage Template On">

:::note
If you choose to activate the storage template engine, it will move all assets to `UPLOAD_LOCATION/library/<userID>`.

When you turn off the storage template engine, it will leave the assets in `UPLOAD_LOCATION/library/<userID>` and will not return them to `/library/upload`.  
**New assets** will be saved to `/library/upload`.
:::

**1. User-Specific Folders:**

- Each user has a unique string representing them.
  - The main user is "Admin" (but only for `UPLOAD_LOCATION/library`)
  - Other users have different string identifiers.
- You can find your user ID in Account Account Settings -> Account -> User ID.

**2. Asset Types and Storage Locations:**

- **Source Assets:**
  - Original assets uploaded through the browser interface & mobile & CLI.
  - Stored in `UPLOAD_LOCATION/library/<userID>`.
- **Avatar Images:**
  - User profile images.
  - Stored in `/library/profile/<userID>`.
- **Thumbs Images:**
  - Preview images (blurred, small, large) for each asset and thumbnails for recognized faces.
  - Stored in `/library/thumbs/<userID>`.
- **Encoded Assets:**
  - By default, unless otherwise specified re-encoded video assets for wider compatibility .
  - Stored in `/library/encoded-video/<userID>`.
- **Files in Upload Queue (Mobile):**
  - Files uploaded through mobile apps.
  - Temporarily located in `/library/upload/<userID>`.
  - Transferred to `UPLOAD_LOCATION/library/<userID>` upon successful upload.

</TabItem>
</Tabs>

:::danger
Do not touch the files inside these folders under any circumstances except taking a backup, changing or removing an asset can cause untracked and missing files.
You can think of it as App-Which-Must-Not-Be-Named, the only access to viewing, changing and deleting assets is only through the mobile or browser interface.
:::

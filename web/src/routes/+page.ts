import { AppRoute } from '$lib/constants';
import { getServerConfig } from '@immich/sdk';
import { redirect } from '@sveltejs/kit';
import { loadUser } from '../lib/utils/auth';
import type { PageLoad } from './$types';

export const ssr = false;
export const csr = true;

export const load = (async () => {
  const authenticated = await loadUser();
  if (authenticated) {
    redirect(302, AppRoute.PHOTOS);
  }

  const { isInitialized } = await getServerConfig();
  if (isInitialized) {
    // Redirect to login page if there exists an admin account (i.e. server is initialized)
    redirect(302, AppRoute.AUTH_LOGIN);
  }

  return {
    meta: {
      title: 'Welcome 🎉',
      description: 'Immich Web Interface',
    },
  };
}) satisfies PageLoad;

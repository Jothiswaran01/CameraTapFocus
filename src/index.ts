import { registerPlugin } from '@capacitor/core';

import type { CameraFocusPlugin } from './definitions';

const CameraFocus = registerPlugin<CameraFocusPlugin>('CameraFocus', {
  web: () => import('./web').then((m) => new m.CameraFocusWeb()),
});

export * from './definitions';
export { CameraFocus };

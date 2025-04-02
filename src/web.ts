import { WebPlugin } from '@capacitor/core';

import type { CameraFocusPlugin } from './definitions';

export class CameraFocusWeb extends WebPlugin implements CameraFocusPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

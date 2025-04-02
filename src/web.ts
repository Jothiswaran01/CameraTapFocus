import { WebPlugin } from '@capacitor/core';
import { CameraFocusPlugin } from './definitions';

export class CameraFocusWeb extends WebPlugin implements CameraFocusPlugin {
  async focusAtPoint(_options: { x: number; y: number }): Promise<void> {
    console.warn('CameraFocus is not available on the web.');
  }
}

const CameraFocus = new CameraFocusWeb();
export { CameraFocus };


import { Plugin } from '@capacitor/core';

export interface CameraFocusPlugin extends Plugin {
  focusAtPoint(options: { x: number; y: number }): Promise<void>;
}


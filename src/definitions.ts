export interface CameraFocusPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}

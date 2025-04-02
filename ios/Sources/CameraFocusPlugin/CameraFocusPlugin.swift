import UIKit
import AVFoundation
import Capacitor

@objc(CameraFocusPlugin)
public class CameraFocusPlugin: CAPPlugin {
    
    private var captureDevice: AVCaptureDevice?
    private var previewLayer: AVCaptureVideoPreviewLayer?

    @objc func focusAtPoint(_ call: CAPPluginCall) {
        let x = call.getDouble("x") ?? 0
        let y = call.getDouble("y") ?? 0
        
        DispatchQueue.main.async {
            self.showFocusRing(at: CGPoint(x: x, y: y))
        }

        if let device = self.captureDevice {
            do {
                try device.lockForConfiguration()
                let focusPoint = CGPoint(x: x / UIScreen.main.bounds.width, y: y / UIScreen.main.bounds.height)
                device.focusPointOfInterest = focusPoint
                device.focusMode = .autoFocus
                device.unlockForConfiguration()
            } catch {
                print("Failed to set focus point")
            }
        }
        call.resolve()
    }

    private func showFocusRing(at point: CGPoint) {
        DispatchQueue.main.async {
            let focusRing = UIImageView(image: UIImage(named: "focusring"))
            focusRing.frame = CGRect(x: point.x - 50, y: point.y - 50, width: 100, height: 100)
            focusRing.alpha = 0.8

            if let window = UIApplication.shared.windows.first {
                window.addSubview(focusRing)
                UIView.animate(withDuration: 0.5, animations: {
                    focusRing.alpha = 0
                }) { _ in
                    focusRing.removeFromSuperview()
                }
            }
        }
    }
}

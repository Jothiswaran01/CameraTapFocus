package com.mycompany.plugins.camerafocus;

import android.app.Activity;
import android.graphics.Rect;
import android.hardware.Camera;
import android.os.Handler;
import android.view.MotionEvent;
import android.view.SurfaceView;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;

import androidx.annotation.NonNull;

import com.getcapacitor.Plugin;
import com.getcapacitor.annotation.CapacitorPlugin;

import java.util.ArrayList;
import java.util.List;

@CapacitorPlugin(name = "CameraFocus")
public class CameraFocusPlugin extends Plugin {

    private Camera camera;
    private SurfaceView cameraPreview;

    @Override
    public void load() {
        Activity activity = getActivity();
        cameraPreview = activity.findViewById(R.id.camera_preview);
        cameraPreview.setOnTouchListener((v, event) -> {
            if (event.getAction() == MotionEvent.ACTION_DOWN) {
                float x = event.getX();
                float y = event.getY();
                showFocusRing(x, y);
                focusAtPoint(x, y);
            }
            return true;
        });
    }

    private void showFocusRing(float x, float y) {
        Activity activity = getActivity();
        activity.runOnUiThread(() -> {
            ImageView focusRing = new ImageView(activity);
            focusRing.setImageResource(R.drawable.focus_ring);

            FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(200, 200);
            params.leftMargin = (int) x - 100;
            params.topMargin = (int) y - 100;
            focusRing.setLayoutParams(params);

            FrameLayout layout = (FrameLayout) activity.findViewById(android.R.id.content);
            layout.addView(focusRing);

            new Handler().postDelayed(() -> layout.removeView(focusRing), 500); // Hide after 0.5 sec
        });
    }

    private void focusAtPoint(float x, float y) {
        if (camera == null) return;
        Camera.Parameters params = camera.getParameters();
        if (params.getMaxNumFocusAreas() > 0) {
            List<Camera.Area> focusAreas = new ArrayList<>();
            Rect focusRect = new Rect((int) x - 50, (int) y - 50, (int) x + 50, (int) y + 50);
            focusAreas.add(new Camera.Area(focusRect, 1000));
            params.setFocusAreas(focusAreas);
            camera.setParameters(params);
            camera.autoFocus(null);
        }
    }
}

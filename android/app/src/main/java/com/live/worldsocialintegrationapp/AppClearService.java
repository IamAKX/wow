package com.live.worldsocialintegrationapp;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;

public class AppClearService extends Service {
    @Override
    public void onTaskRemoved(Intent rootIntent) {
        Log.i("AppClearService", "App was cleared from recent apps");
        System.out.print("App was cleared from recent apps");
        // Perform cleanup or save state here
        stopSelf(); // Optionally stop the service
    }

    @Override
    public IBinder onBind(Intent intent) {
        Log.i("AppClearService", "App Service started");
        System.out.print("App Service started");
        return null;
    }
}
package com.live.worldsocialintegrationapp;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;

public class AppClearService extends Service {
    public AppClearService() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        // TODO: Return the communication channel to the service.
        throw new UnsupportedOperationException("Not yet implemented");
    }
}
package com.live.worldsocialintegrationapp;

import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import com.snap.loginkit.LoginResultCallback;
import com.snap.loginkit.SnapLogin;
import com.snap.loginkit.SnapLoginProvider;
import com.snap.loginkit.exceptions.LoginException;



public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.snapchat/login";
    private SnapLogin snapLogin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        snapLogin = SnapLoginProvider.get(getApplicationContext()); // Ensure context is provided correctly
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("login")) {
                                snapLogin.startTokenGrant(new LoginResultCallback() {
                                    @Override
                                    public void onStart() {
                                        result.success("Login initiated");
                                    }

                                    @Override
                                    public void onSuccess(@NonNull String s) {
                                        result.success("Login success : "+s);
                                    }

                                    @Override
                                    public void onFailure(@NonNull LoginException e) {
                                        result.error(String.valueOf(e.getStatusCode()), e.getMessage(), e);
                                    }
                                });

                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}

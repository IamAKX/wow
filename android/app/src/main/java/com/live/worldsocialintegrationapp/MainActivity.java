package com.live.worldsocialintegrationapp;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import com.snapchat.kit.sdk.SnapLogin;
import com.snapchat.kit.sdk.core.controller.LoginStateController;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;




public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.snapchat/login";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent intent = new Intent(this, AppClearService.class);
        startService(intent);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("login")) {
//                                snapLogin = SnapLoginProvider.get(this);


                                SnapLogin.getLoginStateController(getActivity()).addOnLoginStateChangedListener(new LoginStateController.OnLoginStateChangedListener() {
                                    @Override
                                    public void onLoginSucceeded() {
                                        result.success("Login Success");
                                    }

                                    @Override
                                    public void onLoginFailed() {
                                        result.error("LoginError", "Error Logging In", null);
                                    }

                                    @Override
                                    public void onLogout() {
                                        result.success("Logout Success");
                                    }
                                });
                                SnapLogin.getAuthTokenManager(getActivity()).startTokenGrant();

                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}

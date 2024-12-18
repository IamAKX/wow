package com.live.worldsocialintegrationapp;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import androidx.annotation.NonNull;

import com.snapchat.kit.sdk.SnapLogin;
import com.snapchat.kit.sdk.core.controller.LoginStateController;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;




public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.snapchat/login";

    private WebView webView;
    private ValueCallback<Uri[]> filePathCallback;
    private static final int FILE_CHOOSER_RESULT_CODE = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        View contentView = new View(this);
        contentView.setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_STABLE | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);

        super.onCreate(savedInstanceState);

        Intent intent = new Intent(this, AppClearService.class);
        startService(intent);

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), "com.example.webview/native")
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("openWebView")) {
                        String url = call.argument("url");
                        if (url != null) {
                            openWebView(url);
                        }
                        result.success(null);
                    } else {
                        result.notImplemented();
                    }
                });
    }

    @Override
    public void onBackPressed() {
        if (webView != null && webView.canGoBack()) {
            // If WebView can go back, navigate back in the WebView history
            webView.goBack();
        } else {
            // If WebView cannot go back, behave like normal back press (closing WebView)
            super.onBackPressed();
        }
    }

    @SuppressLint("SetJavaScriptEnabled")
    private void openWebView(String url) {
        Intent intent = new Intent(this, WebViewActivity.class);
        intent.putExtra("url", url);
        startActivity(intent);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == FILE_CHOOSER_RESULT_CODE && resultCode == Activity.RESULT_OK) {
            Uri result = null; // Initialize as null

            if (data != null && data.getData() != null) {
                result = data.getData();
            }

            if (filePathCallback != null) {
                filePathCallback.onReceiveValue(new Uri[]{result});
                filePathCallback = null;
            }
        } else {
            if (filePathCallback != null) {
                filePathCallback.onReceiveValue(null);
                filePathCallback = null;
            }
        }
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

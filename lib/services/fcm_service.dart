import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

class FCMService {
  // Singleton pattern to ensure only one instance of FCMService
  FCMService._privateConstructor();
  static final FCMService instance = FCMService._privateConstructor();

  Future<String?> getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Get the FCM token
    String? token = await messaging.getToken();
    log('FCM Token: $token');

    // Handle token refresh
    messaging.onTokenRefresh.listen((newToken) {
      log('Refreshed FCM Token: $newToken');
      // You can save the new token to your backend or local storage
    });

    return token;
  }

  Future<void> initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permissions on iOS
    if (Platform.isIOS) {
      await _requestNotificationPermissions();
      String? apnsToken = await messaging.getAPNSToken();
      log('APNS Token: $apnsToken');
    }

    // You can call getFCMToken here or anywhere else in your app
    await getFCMToken();

    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Received a message: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Message clicked! Title: ${message.notification?.title}');
    });
  }

  Future<void> _requestNotificationPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }
}

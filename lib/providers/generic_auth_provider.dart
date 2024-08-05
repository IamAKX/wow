import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';

import '../firebase_options.dart';

enum AuthStatus {
  notAuthenticated,
  authenticating,
  authenticated,
}

class GenericAuthProvider extends ChangeNotifier {
  User? user;
  AuthStatus? status = AuthStatus.notAuthenticated;
  late FirebaseAuth _auth;

  static GenericAuthProvider instance = GenericAuthProvider();
  GenericAuthProvider() {
    _auth = FirebaseAuth.instance;
    _checkCurrentUserIsAuthenticated();
  }

  void _checkCurrentUserIsAuthenticated() async {
    user = _auth.currentUser;
    if (user != null) {
      if (user!.emailVerified) {
      } else {
        logoutUser();
      }
    }
  }

  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      await logoutWithGoogle();
      await logoutWithFacebook();
      user = null;
      status = AuthStatus.notAuthenticated;
      showToastMessage('Logged Out');
    } catch (e) {
      showToastMessage('Error Logging Out');
    }
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    status = AuthStatus.authenticating;
    notifyListeners();
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId: (DefaultFirebaseOptions.currentPlatform ==
                    DefaultFirebaseOptions.ios)
                ? DefaultFirebaseOptions.currentPlatform.iosClientId
                : DefaultFirebaseOptions.currentPlatform.androidClientId)
        .signIn()
        .catchError((onError) {
      log('$onError');
      showToastMessage('Error: $onError');
      status = AuthStatus.notAuthenticated;
      notifyListeners();
      return null;
    });
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication.catchError((onError) {
      log('$onError');
      showToastMessage('Error: $onError');
      status = AuthStatus.notAuthenticated;
      notifyListeners();
    });

    OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((onError) {
      log('$onError');
      showToastMessage('Error: $onError');
      status = AuthStatus.notAuthenticated;
      notifyListeners();
    });
    user = userCredential.user;

    if (user != null) {
      log('Google user logged in: ${user?.uid}');
      status = AuthStatus.authenticated;
    } else {
      log('Failed to log in with Google.');
      showToastMessage('Failed to log in with Google.');
      status = AuthStatus.notAuthenticated;
    }

    notifyListeners();
  }

  Future<void> logoutWithGoogle() async {
    await GoogleSignIn(
            clientId: (DefaultFirebaseOptions.currentPlatform ==
                    DefaultFirebaseOptions.ios)
                ? DefaultFirebaseOptions.currentPlatform.iosClientId
                : DefaultFirebaseOptions.currentPlatform.androidClientId)
        .signOut();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(
        length, (index) => charset[random.nextInt(charset.length)]).join();
  }

  Future<void> loginWithFacebook() async {
    status = AuthStatus.authenticating;
    notifyListeners();

    // final LoginResult loginResult =
    //     await FacebookAuth.instance.login().catchError((onError) {
    //   log('$onError');
    //   showToastMessage('Error: $onError');
    //   status = AuthStatus.notAuthenticated;
    //   notifyListeners();
    // });
    // final OAuthCredential facebookAuthCredential =
    //     FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final result = await FacebookAuth.instance.login(
      loginTracking: LoginTracking.limited,
      nonce: nonce,
    );

    if (result.status != LoginStatus.success) {
      showToastMessage('Failed to log in with Facebook.');
      status = AuthStatus.notAuthenticated;
      notifyListeners();
      return;
    }
    final accessToken = result.accessToken;
    OAuthCredential credential;
    if (accessToken is LimitedToken) {
      credential = OAuthCredential(
        providerId: 'facebook.com',
        signInMethod: 'oauth',
        idToken: accessToken.tokenString,
        rawNonce: rawNonce,
      );
    } else if (accessToken is ClassicToken) {
      credential = FacebookAuthProvider.credential(accessToken.tokenString);
    } else {
      throw Exception('Unsupported token type');
    }

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((onError) {
      log('$onError');
      showToastMessage('Error: $onError');
      status = AuthStatus.notAuthenticated;
      notifyListeners();
    });
    user = userCredential.user;
    if (user != null) {
      log('Facebook user logged in: ${user?.uid}');
      status = AuthStatus.authenticated;
    } else {
      log('Failed to log in with Facebook.');
      showToastMessage('Failed to log in with Facebook.');
      status = AuthStatus.notAuthenticated;
    }
    notifyListeners();
  }

  Future<void> logoutWithFacebook() async {
    await FacebookAuth.instance.logOut();
  }
}

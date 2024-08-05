import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      await GoogleSignIn(
              clientId: (DefaultFirebaseOptions.currentPlatform ==
                      DefaultFirebaseOptions.ios)
                  ? DefaultFirebaseOptions.currentPlatform.iosClientId
                  : DefaultFirebaseOptions.currentPlatform.androidClientId)
          .signOut();
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
}

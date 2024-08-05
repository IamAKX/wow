# Firebase Integration

#### On Firebase console

1. Activate Authentication
2. Enable Phone auth
3. Enable Google Auth

#### Packages to be installed

1. firebase_core
2. firebase_auth
3. google_sign_in
4. flutter_facebook_auth

#### On Local terminal

Add Firebase to project

```console
dart pub global activate flutterfire_cli
flutterfire configure
```

Add debug key to firebase console

```console
cd android
./gradlew signingReport
```

#### Platform specific setup

[🍎 iOS Setup](IOS_SETUP.md)
[🤖 Android Setup](ANDROID_SETUP.md)

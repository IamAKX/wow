import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../main.dart';
import '../services/firebase_db_service.dart';
import '../utils/prefs_key.dart';

class BackgroundDetector extends StatefulWidget {
  const BackgroundDetector({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<BackgroundDetector> createState() => _BackgroundDetectorState();
}

class _BackgroundDetectorState extends State<BackgroundDetector>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    log('App Opened');

    WidgetsBinding.instance.addObserver(this);

    FirebaseDbService.updateOnlineStatus(
        prefs.getString(PrefsKey.userId) ?? '', 'Online');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    log('App closed');

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('\x1B[34m $state \x1B[0m');
    FirebaseDbService.updateOnlineStatus(
        prefs.getString(PrefsKey.userId) ?? '', 'Offline');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

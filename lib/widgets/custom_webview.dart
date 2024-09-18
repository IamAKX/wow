import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class CustomWebview extends StatefulWidget {
  const CustomWebview({super.key, required this.url});
  static const String route = '/customWebview';
  final String url;

  @override
  State<CustomWebview> createState() => _CustomWebviewState();
}

class _CustomWebviewState extends State<CustomWebview> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    log('webview loading : ${widget.url}');
    return WebView(
      initialUrl: widget.url,
    );
  }
}

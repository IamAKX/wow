import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CustomWebview extends StatefulWidget {
  const CustomWebview({super.key, required this.url});
  static const String route = '/customWebview';
  final String url;

  @override
  State<CustomWebview> createState() => _CustomWebviewState();
}

class _CustomWebviewState extends State<CustomWebview> {
  @override
  Widget build(BuildContext context) {
    log('webview loading : ${widget.url}');
    return WebviewScaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
      ),
      url: widget.url,
      withZoom: true,
      hidden: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewApp extends StatefulWidget {
  final String websiteUrl;
  const WebViewApp({Key? key,required this.websiteUrl}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.websiteUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
        controller: controller,
    );
  }
}
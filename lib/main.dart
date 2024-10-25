import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webview Platform Mod',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Webview Platform Mod'),
        ),
        body: WebView(),
      ),
    );
  }
}

class WebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Используем MethodChannel для создания платформенного вида
    return UiKitView(
      viewType: 'webview',
      onPlatformViewCreated: (int id) {
        // Здесь можно добавить дополнительные настройки, если нужно
      },
    );
  }
}

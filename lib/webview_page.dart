import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class WebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Native WebView")),
      body: Center(
        child: _buildPlatformWebView(),
      ),
    );
  }

  Widget _buildPlatformWebView() {
    if (Platform.isAndroid) {
      return PlatformViewLink(
        viewType: 'webview',
        surfaceFactory: (context, controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (params) {
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: 'webview',
            layoutDirection: TextDirection.ltr,
            creationParams: null,
            creationParamsCodec: StandardMessageCodec(),
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        },
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'webview',
        layoutDirection: TextDirection.ltr,
        creationParams: null,
        creationParamsCodec: StandardMessageCodec(),
      );
    } else {
      return Center(
        child: Text("Platform not supported"),
      );
    }
  }
}

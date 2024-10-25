package com.example.webview_platform_example

import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.PlatformViewFactory
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewRegistry
import io.flutter.plugin.common.StandardMessageCodec
import android.content.Context
import android.view.View

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("webview", WebViewFactory())
    }
}

class WebViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, id: Int, args: Any?): PlatformView {
        return NativeWebView(context)
    }
}

class NativeWebView(context: Context?) : PlatformView {
    private val webView: WebView = WebView(context!!).apply {
        settings.javaScriptEnabled = true
        webViewClient = WebViewClient() // Позволяет загружать страницу внутри WebView
        loadUrl("https://maritime-zone.com/en/vacancy") // URL страницы
    }

    override fun getView(): View {
        return webView
    }

    override fun dispose() {
        webView.destroy()
    }
}

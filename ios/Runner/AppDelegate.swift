import UIKit
import Flutter
import WebKit

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let registrar = controller.registrar(forPlugin: "webview")!

        registrar.register(WebViewFactory(messenger: registrar.messenger()), withId: "webview")

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

class WebViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return NativeWebView(frame, viewId: viewId, messenger: messenger)
    }
}

class NativeWebView: NSObject, FlutterPlatformView {
    private var webView: WKWebView

    init(_ frame: CGRect, viewId: Int64, messenger: FlutterBinaryMessenger) {
        webView = WKWebView(frame: frame)
        super.init()
        // Загрузка веб-страницы
        webView.load(URLRequest(url: URL(string: "https://maritime-zone.com/en/vacancy")!))
    }

    func view() -> UIView {
        return webView
    }
}

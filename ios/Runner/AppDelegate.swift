import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  var externalWindow: UIWindow?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Register plugins on the default engine.
    GeneratedPluginRegistrant.register(with: self)

    // Warm and cache a dedicated engine for the external display, routed to '/presentation'.
    let presentationEngine = FlutterEngine(name: "presentation_engine")
    presentationEngine.run(withEntrypoint: nil, initialRoute: "/presentation")
    GeneratedPluginRegistrant.register(with: presentationEngine)
    FlutterEngineCache.default().put(presentationEngine, forKey: "presentation_engine")

    // Listen for external display connect/disconnect.
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(screenDidConnect(_:)),
      name: UIScreen.didConnectNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(screenDidDisconnect(_:)),
      name: UIScreen.didDisconnectNotification,
      object: nil
    )

    // If an external screen is already connected at launch, attach now.
    if UIScreen.screens.count > 1 {
      attachExternalScreen(UIScreen.screens[1])
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  @objc func screenDidConnect(_ notification: Notification) {
    guard let screen = notification.object as? UIScreen else { return }
    attachExternalScreen(screen)
  }

  @objc func screenDidDisconnect(_ notification: Notification) {
    externalWindow?.isHidden = true
    externalWindow = nil
  }

  private func attachExternalScreen(_ screen: UIScreen) {
    guard let engine = FlutterEngineCache.default().engine(for: "presentation_engine") else { return }
    let frame = screen.bounds
    let window = UIWindow(frame: frame)
    window.screen = screen

    let vc = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    vc.setInitialRoute("/presentation")

    window.rootViewController = vc
    window.isHidden = false
    externalWindow = window
  }
}

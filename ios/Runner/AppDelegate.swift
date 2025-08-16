import Flutter
import UIKit
import presentation_displays

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Register the plugin's callback for new Flutter ViewControllers
    SwiftPresentationDisplaysPlugin.controllerAdded = { controller in
      // Register plugins for the secondary display's Flutter engine
      GeneratedPluginRegistrant.register(with: controller)
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

import Flutter
import UIKit
import presentation_displays

@main
@objc class AppDelegate: FlutterAppDelegate {
  var flutterEngine: FlutterEngine?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Pre-warm an engine for the presentation display with custom entry point
    let presentationEngine = FlutterEngine(name: "presentation_engine")
    // Use the custom Dart entry point for presentation
    presentationEngine.run(withEntrypoint: "presentationMain")
    GeneratedPluginRegistrant.register(with: presentationEngine)
    self.flutterEngine = presentationEngine
    
    // Register the plugin's callback to use our pre-warmed engine
    SwiftPresentationDisplaysPlugin.controllerAdded = { controller in
      // The plugin created a new controller, but we want to use our engine
      if let engine = self.flutterEngine {
        // Replace the controller's engine with ours
        let newController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        
        // Copy the view from the new controller
        if let window = controller.view.window {
          window.rootViewController = newController
        }
      } else {
        // Fallback: register plugins for the controller
        GeneratedPluginRegistrant.register(with: controller)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

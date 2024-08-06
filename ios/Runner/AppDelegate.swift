import Flutter
import UIKit
import SCSDKLoginKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let snapChannel = FlutterMethodChannel(name: "com.example.snapchat/login",
                                          binaryMessenger: controller.binaryMessenger)
    
    snapChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if (call.method == "login") {
            SCSDKLoginClient.login(from: controller) { (success : Bool, error : Error?) in
                if success {
                    result("Login successful")
                } else {
                    result("Login failed")
                }
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    })
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

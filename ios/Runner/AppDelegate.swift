import UIKit
import Flutter
import zpdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
              let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
              
              let deviceChannel = FlutterMethodChannel(name: "com.tma.payment", binaryMessenger: controller.binaryMessenger)
              
      prepareMethodHandler(deviceChannel: deviceChannel)
      GeneratedPluginRegistrant.register(with: self)
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
            
            deviceChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
                if call.method == "zalo_pay" {
                    PaymentByZl.instance.payment()

                }
                else {
                    
                    return
                }
                
            })
        }
    
    
}



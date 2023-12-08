import UIKit
import Flutter
import GrowingAnalytics_cdp

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
       let config = GrowingAutotrackConfiguration(projectId: "bcc4fc9dea27f25d")
 //      config?.dataCollectionServerHost = "YourServerHost"
       config?.dataSourceId = "be46cd165dcc3c7e"
      config?.debugEnabled=true
       GrowingAutotracker.start(with: config!, launchOptions: launchOptions ?? [:])
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

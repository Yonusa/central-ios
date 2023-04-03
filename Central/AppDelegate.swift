//
//  AppDelegate.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 14/01/23.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

enum Token: String {
case fcmToken = "TOKEN"
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        firebasePushConfiguration(application: application)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

// MARK: - Firebase Push notifications
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    private func firebasePushConfiguration(application: UIApplication) {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
        
    }
    
    // Show notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
        
        let userInfo = notification.request.content.userInfo
        debugPrint(userInfo)
//        let apsPayload: [AnyHashable: Any] = userInfo["aps"] as! [AnyHashable : Any]
//        let idNotification:String = apsPayload["notificationId"] as! String
//        confirmNotification(idNotification: idNotification)

    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        debugPrint(userInfo)
//        let apsPayload: [AnyHashable: Any] = userInfo["aps"] as! [AnyHashable : Any]
//        let idNotification:String = apsPayload["notificationId"] as! String
        
        completionHandler()
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
        Messaging.messaging().subscribe(toTopic: "All")
        Messaging.messaging().delegate = self
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        guard let fcmToken = fcmToken else { return }
        
        debugPrint("FCM token: \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: Token.fcmToken.rawValue)
        
//        if let userId = userDefaults.string(forKey: Constants.userIdUD) {
//            // Saving token for Push notification
//            LoginServices().registerNotification(usrIDUD: userId, notificationId: fcmToken, completion: { defaultModel in
//                // Do some in case you need it
//                self.userDefaults.set(fcmToken, forKey: Constants.idNotification)
//            })
//        } else {
//            // Save it in defaults, will use it in logIn
//            userDefaults.set(fcmToken, forKey: Constants.idNotification)
//            debugPrint("TOKEN SAVED DEFAULTS")
//        }
        
    }
}

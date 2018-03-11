//
//  AppDelegate.swift
//  blista
//
//  Created by Falk Rismansanj on 30.11.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Firebase
import UserNotifications
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do {
            if let url = Bundle.main.url(forResource: "fabric.apikey", withExtension: nil) {
                let key = try String(contentsOf: url, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
                Crashlytics.start(withAPIKey: key)
            }
        } catch {
            NSLog("Could not retrieve Crashlytics API key. Check that fabric.apikey exists, contains your Crashlytics API key, and is a member of the target")
        }
        
        if let tabBarController = window?.rootViewController as? UITabBarController {            
            tabBarController.customizableViewControllers = nil
        }

        let blistaColor = UIColor(red: 0, green: 0.651, blue: 0.1137, alpha: 1)
        
        self.window?.tintColor = blistaColor
        
        if #available(iOS 9.0, *) {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = blistaColor
        } else {

        }
        
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self as? MessagingDelegate
        
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            // Handle setCategory failure
            print(error)
        }
        
        return true
        
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        SettingsBundleHelper.setVersionAndBuildNumber()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


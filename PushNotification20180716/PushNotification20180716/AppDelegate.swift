//
//  AppDelegate.swift
//  PushNotification20180716
//
//  Created by steve on 2018-07-16.
//  Copyright © 2018 steve. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    registerForNotifications(remote: true)
    return true
  }
}


extension AppDelegate {
  // Register to receive notifications
  
  private func registerForNotifications(remote: Bool = false) {
    UNUserNotificationCenter.current().requestAuthorization(options:
    [.alert, .sound, .badge]) {
      (granted, error) in
      print(#line, "Permission granted: \(granted)")
      guard granted else { return }
      self.checkNotificationSettings(remote: remote)
    }
  }
  
  
  private func checkNotificationSettings(remote: Bool) {
    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
      print(#line, "Settings: \(settings)")
      guard settings.authorizationStatus == .authorized else {
        // Good place to notify the user how not having notifications might affect their experience
        return
      }
      // Register for Remove Notifications
      if remote {
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
  }
  
  
  // Remove notification Callbacks
  
  func application(_ application: UIApplication,
                   didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenParts = deviceToken.map { data -> String in
      return String(format: "%02.2hhx", data)
    }
    let token = tokenParts.joined()
    print("Device Token: \(token)")
    print(#line, token)
    // you could send this token to a server, but don't rely on it because it will change if the user deletes the app for example
  }
  
  func application(_ application: UIApplication,
                   didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed with error: \(error)")
  }
}


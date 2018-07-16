//
//  ViewController.swift
//  LocalNotificationsExample
//
//  Created by steve on 2018-07-16.
//  Copyright © 2018 steve. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
  
  let notificationCenter = UNUserNotificationCenter.current()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNotifications()
  }
  
  fileprivate func createNotification() {
    
    notificationCenter.getNotificationSettings(completionHandler: { (settings) in
      
      if settings.authorizationStatus != .authorized {
        print(#line, "Not authorized")
        return
      }
      
      DispatchQueue.main.async {
        addAlert()
      }
      func addAlert() {
        let alertEnabled = settings.alertSetting == .enabled
        let soundEnabled = settings.soundSetting == .enabled
        
        let content = UNMutableNotificationContent()
        if alertEnabled {
          
          // for adding the image attachment
          let url = Bundle.main.url(forResource: "image1", withExtension: "png")
          let imageAttachment = try! UNNotificationAttachment(identifier: "image1", url: url!)
//          let url2 = Bundle.main.url(forResource: "sound", withExtension: "caf")
//          let soundAttachment = try! UNNotificationAttachment(identifier: "sound1", url: url2!)
          content.attachments = [imageAttachment]
          
          // alert text
          content.title = "My title"
          content.subtitle = "This is a subtitle"
          content.body = "This is the body"
          
          // Sound
                  if soundEnabled {
                    content.sound = UNNotificationSound(named: "sound.caf")
                  }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let request =  UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        
        self.notificationCenter.add(request, withCompletionHandler: { (error) in
          
          if let error = error {
            print(#line, error.localizedDescription)
          }
        })
        
        
      }
      
      
      
    })
  }
  
  private func setupNotifications() {
    notificationCenter.requestAuthorization(options: [.alert, .sound]) {[weak self] (granted, error) in
      
      if granted == false {
        print(#line, error?.localizedDescription ?? "No error message")
        return
      }
      self?.createNotification()
      
    }
  }
  
  
}


//
//  UNNotificationManager.swift
//  UserNotificationExample
//
//  Created by giftbot on 2019. 5. 28..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit
import UserNotifications


final class UNNotificationManager: NSObject {
  enum Identifier {
    static let basicCategory = "BasicCategory"
    static let anotherCategory = "AnotherCategory"
    
    static let timeIntervalRequest = "TimeIntervalRequest"
    static let calendarRequest = "CanlendarRequest"
    
    static let repeatAction = "RepeatAction"
    static let removeAction = "RemoveAction"
    static let textInputAction = "TextInputAction"
  }
    
    // singleTon
    private let center = UNUserNotificationCenter.current()
  
  func register() {
    
    center.delegate = self
    let options: UNAuthorizationOptions = [.alert, .badge, .sound, ]
    center.requestAuthorization(options: options) { (isGranted, error) in
        guard isGranted else { print(error?.localizedDescription ?? "")
        return self.requestAlertNotification()
        }
        print("granted")
        self.setupNotificationCategories()
    }
  }
    
    func getNotificationSettings(with completionHandler: @escaping (Bool) -> Void) {
        center.getNotificationSettings {
            completionHandler($0.authorizationStatus == .authorized)
        }
    }
    
    private func requestAlertNotification() {
        guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        DispatchQueue.main.async {
            UIApplication.shared.open(settingUrl)
        }
    }

  
  /***************************************************
   SetupNotificationCategories
   ***************************************************/
  
  func setupNotificationCategories() {
    let repeatAction = UNNotificationAction(identifier: Identifier.repeatAction, title: "Repeat", options: [])
    
    let basicCategory = UNNotificationCategory(identifier: Identifier.basicCategory,
                                               actions: [repeatAction],
                                               intentIdentifiers: []
                                               )
    
    
//    center.setNotificationCategories([basicCategory])
    
    /***
     .foreground : 버튼 눌렀을 때 앱을 실행하도록
     .destructive : delete, remove 등 주의해야 하는 작업에 적용
     .authenticationRequired : 디바이스 락이 걸린 상태로 사용 못하도록 함
 
 ***/
    let removeAction = UNNotificationAction(identifier: Identifier.removeAction, title: "Remove", options: [.destructive, .foreground,])
    
    let textInputAction = UNTextInputNotificationAction(identifier: Identifier.textInputAction,
                                                        title: "Change Title",
                                                        options: [.authenticationRequired],
                                                        textInputButtonTitle: "Save",
                                                        textInputPlaceholder: "Repeat wuth input Message")
    let anotherCategory = UNNotificationCategory(
        identifier: Identifier.anotherCategory,
        actions: [removeAction, textInputAction],
        intentIdentifiers: [],
        options: [.customDismissAction]
    )
    center.setNotificationCategories(
        [basicCategory, anotherCategory]
    )
    
  }
  
  
  
  /***************************************************
   TimeIntervalNotification - TimeInterval로 지정한 시간(초) 이후로 알림 등록
   ***************************************************/
  
  func triggerTimeIntervalNotification(with title: String, timeInterval: TimeInterval = 3.0) {
    
    let content = UNMutableNotificationContent()
    content.categoryIdentifier = Identifier.anotherCategory
    content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
    
    content.body = NSString.localizedUserNotificationString(forKey: "Alarm fired", arguments: nil)
    
    //content.sound = .default
    
    let soundName = UNNotificationSoundName(rawValue: "sweetalertsound4.wav")
    content.sound = UNNotificationSound(named: soundName)
    
    // badge
    content.badge = 1
    
    // Attachment
    /*
     audio : 5Mb
     image : 10Mb
     video : 50Mb
     */
    if let imageUrl = Bundle.main.url(forResource: "IU", withExtension: "png") {
        let attachment = try! UNNotificationAttachment(identifier: "attachmentImage",
                                                       url: imageUrl)
        content.attachments = [attachment]
        
    }
    // repeat : true 는 60초 이상일 경우만 된다
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
    let request = UNNotificationRequest(identifier: Identifier.timeIntervalRequest,
                                        content: content,
                                        trigger: trigger)
    center.add(request)
  }
  
  
  
  /***************************************************
   CalendarNotification - 특정 날짜/시간을 지정하여 알림 등록
   ***************************************************/
  
  func triggerCalendarNotification(with title: String, dateComponents: DateComponents) {
    let content = UNMutableNotificationContent()
    content.categoryIdentifier = Identifier.basicCategory
    content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
    content.sound = .default
    content.userInfo = ["Name": "Giftbot"]
    
    if let soundURL = Bundle.main.url(forResource: "pup-alert", withExtension: "mp3") {
        let soundAttachment = try! UNNotificationAttachment(
            identifier: "SoundAttachment", url: soundURL
        )
        content.attachments = [soundAttachment]
    }
    
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents,
        repeats: false
    )
    let request = UNNotificationRequest(
        identifier: Identifier.calendarRequest,
        content: content,
        trigger: trigger
    )
    center.add(request)
    
  }
  
}

//MARK: - UNUserNotificationCenterDelegate
extension UNNotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent")
        print(notification)
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive")
        
        let content = response.notification.request.content
        let categoryID = content.categoryIdentifier
        
        if categoryID == Identifier.basicCategory {
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                print("Tap Notification")
            case Identifier.repeatAction:
                print("Repeat Action")
                triggerTimeIntervalNotification(with: "remainder")
            default:
                print("unknown action")
            }
        }else if categoryID == Identifier.anotherCategory {
            switch response.actionIdentifier {
            case UNNotificationDismissActionIdentifier: // X 버튼 눌렀을 떄 액션 ID
                print("Dismiss Notification")
            case Identifier.removeAction:
                print("remove Action")
                // Remove Some Data
            case Identifier.textInputAction:
                if let inputResponse = response as? UNTextInputNotificationResponse {
                    triggerTimeIntervalNotification(with: inputResponse.userText)
                }
            default:
                print("Unknown Action")
                
            }
        }
        
        print(response)
        completionHandler()
    }
}

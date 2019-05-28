//
//  AppDelegate.swift
//  UserNotificationExample
//
//  Created by giftbot on 2019. 5. 28..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
    
    let notiManager = UNNotificationManager()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // 앱이 시작되자 마자 노티가 날아오면 받을 수 있도록 하기 위함
    notiManager.register()
    return true
  }
}


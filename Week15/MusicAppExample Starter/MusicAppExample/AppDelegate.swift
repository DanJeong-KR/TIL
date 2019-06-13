//
//  AppDelegate.swift
//  MusicAppExample
//
//  Created by Wi on 11/06/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        tabBarController.addChild(UINavigationController(rootViewController: SearchVC()))
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
        return true
    }

}


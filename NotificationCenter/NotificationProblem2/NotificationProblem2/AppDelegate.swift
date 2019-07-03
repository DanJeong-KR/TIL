//
//  AppDelegate.swift
//  NotificationProblem2
//
//  Created by chang sic jung on 30/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let firstVC = FirstViewController()
        firstVC.title = "FirstVC"
        
        let secondVC = SecondViewController()
        secondVC.title = "SecondVC"
        //secondVC.viewDidLoad()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstVC,secondVC]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        return true
    }
}


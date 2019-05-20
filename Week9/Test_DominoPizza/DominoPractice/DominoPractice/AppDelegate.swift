//
//  AppDelegate.swift
//  DominoPractice
//
//  Created by chang sic jung on 01/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let firstVC = FirstViewController()
        firstVC.title = "First"
        
        let secondVC = SecondViewController()
        secondVC.title = "Second"
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstVC, secondVC]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}


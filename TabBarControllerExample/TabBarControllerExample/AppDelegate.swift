//
//  AppDelegate.swift
//  TabBarControllerExample
//
//  Created by chang sic jung on 05/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        //TabBarController
        let tabBarController = UITabBarController()
        
        //FirstViewController
        let firstVC = FirstViewController()
        firstVC.title = "First"
        // firstVC.view.backgroundColor = .gray
        
        //NavigationControlelr
        let navigationController = UINavigationController(rootViewController: firstVC)
        
        //SecondViewController
        let secondVC = SecondViewController()
        secondVC.title = "Second"
        
        
        tabBarController.viewControllers = [navigationController,secondVC]
        
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }


}


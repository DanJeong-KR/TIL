//
//  AppDelegate.swift
//  MapKitPractice
//
//  Created by chang sic jung on 11/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let naviVC = UINavigationController()
        window?.rootViewController = naviVC
        naviVC.viewControllers = [ViewController()]
        //window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }

}


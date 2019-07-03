//
//  AppDelegate.swift
//  ProblemAutoLayout
//
//  Created by chang sic jung on 09/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        return true
    }
    
    func setupWindow() {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = RealViewController()
        window?.makeKeyAndVisible() // key window 로 만드는 과정
    }

}


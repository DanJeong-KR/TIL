//
//  AppDelegate.swift
//  ScrollViewByCode
//
//  Created by chang sic jung on 13/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    /*
     ### UIWindow class Overview
     Windows work **with your view controllers** to **handle events** and to perform many other tasks that are fundamental to your app’s operation. (가장 기초적인 도화지 라고 생각하면 될듯)
     Window 는
     * Provide a main window to display your app’s content.
     
     * Showing windows and making them the target of keyboard events. (**key window**)
            * Only one window at a time can be the key window
            * key 윈도우만 키보드 쓸 수 있음.

     * Changing the root view controller of a window.
            * Windows do not have any visual appearance of their own.
            * Instead, a window hosts one or more views, which are managed by the window's root view controller
            * window는 화면에 뭔가를 표현하진 못하는데 그래서 표현을 할 수 있는 root view controller 를 가질 수 있다.
     */
    
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        // 디바이스에 연결된 main 스크린의 속성 중 bounds 를 가져옴.
        // 디바이스가 아이폰 이므로 아이폰의 screen 이 될 것.
        
        window?.backgroundColor = .white
        // window 의 배경은 디폴트가 clear 라서 배경 지정해 주어야 한다.

//        window 의 background 를 설정해도 되고 window 위에 올라가는 ViewController 의 background color 를 설정해주어도 된다.
//        let root = ViewController()
//        root.view.backgroundColor = .white
        
        window?.rootViewController = ViewController()
         // 화면에 표현할 수 있는 아이인 UIViewController 객체 받고
        
        window?.makeKeyAndVisible()
        // Shows the window and makes it the key window.
        
        
        //
    }



}


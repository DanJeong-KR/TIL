//
//  ViewController.swift
//  AutoLayoutExample
//
//  Created by chang sic jung on 09/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var BlueView: UIView!
    @IBOutlet weak var ReadView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view.safeAreaInsets
        // UIApplication.shared.statusBarFrame
        
        
        //print(UIApplication.shared.statusBarFrame)
        
    }
    
    // 화면이 돌아갈 때마다 호출 되는 메소드?
    // viewWillAppear -> viewWillLayoutSubviews -> viewDidLayoutSubviews -> viewDidAppear
    // viewWillLayoutSubviews 에서 safeAreaInset 프로퍼티 사용가능
    // 정확히 말하면 viewWillLayoutSubviews 전에 ViewSafeAreaInsetsDisChanged () 부터 사용가능 한 것.
    override func viewWillLayoutSubviews() {
//        print(view.safeAreaInsets.left)
//        print(view.safeAreaInsets.right)
//        print(view.safeAreaInsets.top)
//        print(view.safeAreaInsets.bottom)
        
        print(view.frame.height)
        
        BlueView.frame.size = CGSize(width: view.center.x - 5 - view.safeAreaInsets.right - 20,
                                     height: view.frame.height - view.safeAreaInsets.top - 20 - 20 - view.safeAreaInsets.bottom)
        BlueView.frame.origin = CGPoint(x: view.safeAreaInsets.left + 20,
                                        y: view.safeAreaInsets.top + 20)
        
        ReadView.frame.size = CGSize(width: view.center.x - 5 - view.safeAreaInsets.right - 20,
                                     height: view.frame.height - view.safeAreaInsets.top - 20 - 20 - view.safeAreaInsets.bottom)
        ReadView.frame.origin = CGPoint(x: view.center.x + 5,
                                        y: view.safeAreaInsets.top + 20)
        
        
        
    }
    
}


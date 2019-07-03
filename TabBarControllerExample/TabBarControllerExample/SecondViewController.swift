//
//  SecondViewController.swift
//  TabBarControllerExample
//
//  Created by chang sic jung on 05/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // title = "SecondVC"
        // 눌러야 SecondVC 가 보이는 문제. -> AppDelegate 파일에서 타이틀 설정해야
        
        self.view.backgroundColor = .yellow
    }
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---B view did load---")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("---B view will appear---")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("--- B view did appear---")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("--- B view will disappear---")
    }
*/
    

}

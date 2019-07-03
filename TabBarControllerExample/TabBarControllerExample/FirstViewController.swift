//
//  ViewController.swift
//  TabBarControllerExample
//
//  Created by chang sic jung on 05/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        navigationController?.title = "FirstVC"
        
        let barButtonItem = UIBarButtonItem(title: "next", style: .done, target: self, action: #selector(barButtonAction(_:)))
        
        navigationItem.rightBarButtonItem = barButtonItem
        
    }
    
    @objc func barButtonAction (_ sender: Any) {
        let thirdViewController = ThirdViewController()
        
        navigationController?.pushViewController(thirdViewController, animated: true)
    }
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---A view did load---")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("---A view will appear---")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("--- A view did appear---")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("--- A view will disappear---")
    }

     */
}


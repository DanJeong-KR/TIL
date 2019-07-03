//
//  ViewController.swift
//  ProblemBogusAlert
//
//  Created by chang sic jung on 09/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var btAlert: UIButton!
    
    var test = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btAlert.layer.cornerRadius = 5
        btAlert.addTarget(self, action: #selector(btAction(_:)), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(test)
    }
    
    
    @objc func btAction(_ sender: Any?) {
        
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? SecondViewController else {return}
        secondVC.modalPresentationStyle = .overCurrentContext
        present(secondVC, animated: true)
        
    }
}




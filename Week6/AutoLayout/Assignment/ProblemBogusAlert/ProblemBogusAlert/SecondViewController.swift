//
//  SecondViewController.swift
//  ProblemBogusAlert
//
//  Created by chang sic jung on 09/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var viewGray: UIView!
    
    @IBOutlet weak var btYellow: UIButton!
    @IBOutlet weak var btWhite: UIButton!
    @IBOutlet weak var btYes: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewGray.layer.cornerRadius = 5
        btYellow.layer.cornerRadius = btYellow.frame.height / 2
        btWhite.layer.cornerRadius = btWhite.frame.height / 2
        btYes.layer.cornerRadius = 15
        
        btYes.addTarget(self, action: #selector(yesAction(_:)), for: .touchUpInside)
        btYellow.addTarget(self, action: #selector(yellowAction(_:)), for: .touchUpInside)
        btWhite.addTarget(self, action: #selector(WhiteAction(_:)), for: .touchUpInside)
    }
    
    @objc func yesAction(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
        
    }
    
    @objc func yellowAction(_ sender: Any) {
        //guard let firstVC = storyboard?.instantiateViewController(withIdentifier: "FirstVC") as? FirstViewController else {print("dd");return}
        guard let firstVC = presentingViewController as? FirstViewController else { return }
        firstVC.view.backgroundColor = .yellow
    }
    
    @objc func WhiteAction(_ sender: Any) {
        guard let firstVC = presentingViewController as? FirstViewController else { return }
        firstVC.view.backgroundColor = .white
    }
    
    
    

}

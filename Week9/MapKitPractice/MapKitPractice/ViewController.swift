//
//  ViewController.swift
//  MapKitPractice
//
//  Created by chang sic jung on 11/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myLocationPracticeBtn: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Location", for: .normal)
        return button
    }
    var geocodePracticeBtn: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Geocode", for: .normal)
        return button
    }
    var annotationPracticeBtn: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("annotation", for: .normal)
        return button
    }
    var rendererPracticeBtn: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("renderer", for: .normal)
        return button
    }
    var calloutActionPracticeBtn: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("calloutAction", for: .normal)
        return button
    }

    lazy var btnArr = [myLocationPracticeBtn, geocodePracticeBtn, annotationPracticeBtn, rendererPracticeBtn, calloutActionPracticeBtn, ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        view.backgroundColor = .white
        
        for (idx,btn) in btnArr.enumerated() {
            view.addSubview(btn)
            btn.frame = CGRect(x: 100, y: (idx+1)*90, width: 100, height: 50)
            btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        }
    }
    
    @objc func btnAction(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Location":
            let vc = LocationViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }


}


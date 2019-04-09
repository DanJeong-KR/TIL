//
//  RealViewController.swift
//  ProblemAutoLayout
//
//  Created by chang sic jung on 09/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class RealViewController: UIViewController {
    
    private let view1 = UIView()
    private let view2 = UIView()
    private let view3 = UIView()
    private let view4 = UIView()
    private let view5 = UIView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views = [view1, view2, view3, view4, view5]
        
        for i in views {
            view.addSubview(i)
            i.backgroundColor = .black
            i.translatesAutoresizingMaskIntoConstraints = false
            i.heightAnchor.constraint(equalToConstant: 150).isActive = true // 높이 모두 150
        }
        
        //view1.frame = CGRect(x: 30, y: 30, width: 100, height: 100)\
        //view1.frame.size = CGSize(width: 100, height: 100)
        setupLayoutAnchor()
    }
    
    func setupLayoutAnchor() {
        
        // view 1
        view1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        view1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        //view1.trailingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 8)
        //view1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //view1.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        // view2
        view2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        view2.leadingAnchor.constraint(equalTo: view1.trailingAnchor, constant: 8).isActive = true
        view2.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.7).isActive = true
        
        // view3
        view3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        view3.leadingAnchor.constraint(equalTo: view2.trailingAnchor, constant: 8).isActive = true
        view3.widthAnchor.constraint(equalTo: view2.widthAnchor, multiplier: 0.7).isActive = true
        
        // view4
        view4.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        view4.leadingAnchor.constraint(equalTo: view3.trailingAnchor, constant: 8).isActive = true
        view4.widthAnchor.constraint(equalTo: view3.widthAnchor, multiplier: 0.7).isActive = true
        
        // view5
        view5.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        view5.leadingAnchor.constraint(equalTo: view4.trailingAnchor, constant: 8).isActive = true
        view5.widthAnchor.constraint(equalTo: view4.widthAnchor, multiplier: 0.7).isActive = true
        view5.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
    }
}

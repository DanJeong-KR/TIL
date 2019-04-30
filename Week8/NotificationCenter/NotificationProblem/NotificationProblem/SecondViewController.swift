//
//  SecondViewController.swift
//  NotificationProblem
//
//  Created by chang sic jung on 30/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(myView)
        
        myView.backgroundColor = .red
        myView.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            myView.leadingAnchor.constraint(equalTo: guide.leadingAnchor,constant: 10),
            myView.trailingAnchor.constraint(equalTo: guide.trailingAnchor,constant: -10),
            myView.topAnchor.constraint(equalTo: guide.topAnchor,constant: 10),
            myView.bottomAnchor.constraint(equalTo: guide.bottomAnchor,constant:  -10)
            ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(setColorButton(sender:)), name: Notification.Name("button"), object: nil)
        
    }
    
    @objc func setColorButton(sender: Notification) {
        
        print("hi")
        guard let userInfo = sender.userInfo as? [String:Float] else { return }
        let red = CGFloat(userInfo["red"]!)
        let green = CGFloat(userInfo["green"]!)
        let blue = CGFloat(userInfo["blue"]!)
        let alpha = CGFloat(userInfo["alpha"]!)
        myView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
    }
}

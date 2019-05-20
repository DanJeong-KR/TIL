//
//  DetailViewController.swift
//  DominoPizzaExam
//
//  Created by Kira on 24/04/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

@IBDesignable
final class DetailViewController: UIViewController {
    
    let imgView = UIImageView()
    let label = UILabel()
    let minusButton = UIButton(type: .system)
    let plusButton = UIButton(type: .system)
    
    var pizzaTitle = ""
    var pizzaName = ""
    var pizzaIndex:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = pizzaName
        
        view.addSubview(imgView)
        imgView.frame = CGRect(x: 0, y: 200, width:view.frame.width, height: 400)
        imgView.image = UIImage(imageLiteralResourceName: pizzaName)
        
        view.backgroundColor = .white
        
        setup()
    }
    
    func setup() {
        view.addSubview(label)
        view.addSubview(minusButton)
        view.addSubview(plusButton)
        
        label.backgroundColor = .red
        label.text = "0개"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.frame = CGRect(x: 150, y: 700, width: 130, height: 40)
        
        //plusButton.backgroundColor = .blue
        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        plusButton.frame = CGRect(x: 100, y: 700, width: 50, height: 40)
        plusButton.addTarget(self, action: #selector(plusAction(sender:)), for: .touchUpInside)
        
        //minusButton.backgroundColor = .blue
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        minusButton.frame = CGRect(x: 280, y: 700, width: 50, height: 40)
        minusButton.addTarget(self, action: #selector(minusAction(sender:)), for: .touchUpInside)
        
    }
    
    @objc func plusAction(sender: UIButton) {
        DataManager.shared.addCount(pizzaTitle: pizzaTitle, pizzaIndex: pizzaIndex)
        label.text = String(DataManager.shared.returnCount(pizzaTitle: pizzaTitle, pizzaIndex: pizzaIndex)) + "개"
    }
    
    @objc func minusAction(sender: UIButton) {
        
        DataManager.shared.minusCount(pizzaTitle: pizzaTitle, pizzaIndex: pizzaIndex)
        label.text = String(DataManager.shared.returnCount(pizzaTitle: pizzaTitle, pizzaIndex: pizzaIndex)) + "개"
        
    }
    
    //commit
    
    //coommit
    
    
}

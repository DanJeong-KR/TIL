//
//  ViewController.swift
//  NotificationProblem
//
//  Created by chang sic jung on 30/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let redLabel = UILabel()
    let redSlider = UISlider()
    
    let greenLabel = UILabel()
    let greenSlider = UISlider()
    
    let blueLabel = UILabel()
    let blueSlider = UISlider()
    
    let alphaLabel = UILabel()
    let alphaSlider = UISlider()
    
    let button = UIButton(type: .system)
    
    var red: Float = 0
    var green: Float = 0
    var blue: Float = 0
    var alpha: Float = 0
    
    var temp: [String:Float] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        layout()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "button"), object: nil, userInfo: temp)
    }
    
    func configure() {
        let labelArr = [redLabel, greenLabel, blueLabel, alphaLabel]
        let sliderArr = [redSlider, greenSlider, blueSlider, alphaSlider]
        
        for label in labelArr {
            view.addSubview(label)
            label.textAlignment = .center
        }
        for (idx,slider) in sliderArr.enumerated() {
            view.addSubview(slider)
            slider.maximumValue = 1.0
            slider.minimumValue = 0
            slider.addTarget(self, action: #selector(sliderAction(sender:)), for: .valueChanged)
            slider.tag = idx + 1
        }
        //alphaSlider.value = 1
        
        redLabel.text = "Red"
        greenLabel.text = "Green"
        blueLabel.text = "Blue"
        alphaLabel.text = "Alpha"
        
        view.addSubview(button)
        button.setTitle("setColor", for: .normal)
        button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
    }
    
    func layout() {
        
        redLabel.frame = CGRect(x: 30, y: 100, width: 80, height: 50)
        redSlider.frame = CGRect(x: 110, y: 100, width: 250, height: 50)
        
        greenLabel.frame = CGRect(x: 30, y: 150, width: 80, height: 50)
        greenSlider.frame = CGRect(x: 110, y: 150, width: 250, height: 50)
        
        blueLabel.frame = CGRect(x: 30, y: 200, width: 80, height: 50)
        blueSlider.frame = CGRect(x: 110, y: 200, width: 250, height: 50)
        
        alphaLabel.frame = CGRect(x: 30, y: 250, width: 80, height: 50)
        alphaSlider.frame = CGRect(x: 110, y: 250, width: 250, height: 50)
        
        button.frame = CGRect(x: 110, y: 300, width: 80, height: 50)
    }
    
    @objc func sliderAction(sender: UISlider) {
        
        switch sender.tag {
        case 1: // red
            red = sender.value
            print(red)
        case 2: // green
            green = sender.value
            print(green)
        case 3: // blue
            blue = sender.value
        case 4: // alpha
            alpha = sender.value
        default:
            break
        }
    }
    
    @objc func buttonAction(sender: UIButton){
        
        temp = ["red":red,"green":green,"blue":blue,"alpha":alpha]
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "button"), object: nil, userInfo: temp)
    }

}


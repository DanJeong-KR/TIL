//
//  ViewController.swift
//  AnimationProblem
//
//  Created by chang sic jung on 14/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("버튼0", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.center = CGPoint(x: 40, y: 700)
        button.frame.size = CGSize(width: 7
            0, height: 70)
        button.backgroundColor = .red
        button.layer.cornerRadius = button.frame.width / 2
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private var buttonArr: [UIButton] = []
    
    private var isButtonsUp: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in (1..<5) {
            let button = UIButton(type: .system)
            button.setTitle("버튼"+String(i), for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.center = self.button.center
            button.frame.size = CGSize(width: 70, height: 70)
            button.backgroundColor = .red
            button.layer.cornerRadius = button.frame.width / 2
            view.addSubview(button)
            buttonArr.append(button)
        }
        
        view.addSubview(button)
        //button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        
        
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        print("haha")
        isButtonsUp.toggle()
        if isButtonsUp {
            UIView.animate(withDuration: 0.6,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0,
                           options: [.curveEaseInOut],
                           animations: {
                            for value in (1..<5) {
                                self.buttonArr[value-1].center.y -= CGFloat(value*100)
                                self.buttonArr[value-1].frame.size = CGSize(width: 70, height: 70)
                            }
            })
        }else {
            print("haha2")
        }
        
    }


}


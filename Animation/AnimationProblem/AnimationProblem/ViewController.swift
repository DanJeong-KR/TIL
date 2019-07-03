//
//  ViewController.swift
//  AnimationProblem
//
//  Created by chang sic jung on 14/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var firstButtonArr: [UIButton] = []
    private var secondButtonArr: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFirstButtons()
        setupSecondButtons()
        
        firstButtonArr[0].setTitle("나는", for: .normal)
        firstButtonArr[1].setTitle("수연", for: .normal)
        firstButtonArr[2].setTitle("노래", for: .normal)
        firstButtonArr[3].setTitle("하는", for: .normal)
        firstButtonArr[4].setTitle("AI", for: .normal)
        
        imageViewLayout()
        
    }
    func imageViewLayout() {
        
        view.addSubview(imageView)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: guide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            ])
    }
    
    private func randomColorGenerator() -> UIColor {
        let red = CGFloat.random(in: 0...1.0)
        let green = CGFloat.random(in: 0...1.0)
        let blue = CGFloat.random(in: 0...1.0)
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private func setupFirstButtons() {
        for i in 0..<5 {
            let buttonFrame = CGRect(x: 50, y: view.bounds.height - 120, width: UIValue.menuSize.rawValue, height: UIValue.menuSize.rawValue)
            let button = UIButton(type: .system)
            button.frame = buttonFrame
            button.backgroundColor = randomColorGenerator()
            button.setTitle("버튼\(i)", for: .normal)
            button.layer.cornerRadius = button.bounds.width / 2
            button.transform = button.transform.scaledBy(x: UIValue.minScale.rawValue, y: UIValue.minScale.rawValue)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            view.addSubview(button)
            
            firstButtonArr.append(button)
        }
        let activeButton = firstButtonArr.first!
        activeButton.transform = .identity
        activeButton.addTarget(self, action: #selector(firstButtonAction(_:)), for: .touchUpInside)
        view.bringSubviewToFront(activeButton)
        
    }
    
    private func setupSecondButtons() {
        for i in 0..<5 {
            let buttonFrame = CGRect(x: 300, y: view.bounds.height - 120, width: UIValue.menuSize.rawValue, height: UIValue.menuSize.rawValue)
            let button = UIButton(type: .system)
            button.frame = buttonFrame
            button.backgroundColor = randomColorGenerator()
            button.setTitle("버튼\(i)", for: .normal)
            button.layer.cornerRadius = button.bounds.width / 2
            button.transform = button.transform.scaledBy(x: UIValue.minScale.rawValue, y: UIValue.minScale.rawValue)
            view.addSubview(button)
            
            secondButtonArr.append(button)
        }
        let activeButton = secondButtonArr.first!
        activeButton.transform = .identity
        activeButton.addTarget(self, action: #selector(secondButtonAction(_:)), for: .touchUpInside)
        view.bringSubviewToFront(activeButton)
    }
    
    @objc private func firstButtonAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        UIView.animate(withDuration: Time.long.rawValue,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut],
                       animations: {
       
                        var temp = 0
                        self.firstButtonArr.forEach {
                            guard temp != 0 else { temp += 1; return }
                            
                            if sender.isSelected
                            {
                                $0.transform = .identity
                                $0.center.y -= UIValue.distance.rawValue * CGFloat(temp)
                            }else {
                                $0.transform = $0.transform.scaledBy(x: UIValue.minScale.rawValue, y: UIValue.minScale.rawValue)
                                $0.center.y += UIValue.distance.rawValue * CGFloat(temp)
                            }
                            temp += 1
                        }
        })
    }
    
    @objc private func secondButtonAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        UIView.animateKeyframes(withDuration: Time.long.rawValue,
                                delay: 0,
                                options: [.beginFromCurrentState],
                                animations: {
                                    
                                    let stdTime = Time.long.rawValue / Double(self.secondButtonArr.count)
                                    
                                    if sender.isSelected { // 버튼들 올라갈 때
                                        for idx in 1..<self.secondButtonArr.count {
                                            
                                            UIView.addKeyframe(withRelativeStartTime: std0Time * Double((idx)),
                                                               relativeDuration: stdTime,
                                                               animations: {
                                                                self.secondButtonArr[idx].transform = .identity
                                                                let moveButtons = self.secondButtonArr[idx...self.secondButtonArr.count-1]
                                                                moveButtons.forEach{ $0.center.y -= UIValue.distance.rawValue * CGFloat(1) }
                                            })
                                        }
                                    }else { // 버튼들 내려갈 때
                                        
                                        for (time,idx) in (1..<self.secondButtonArr.count).reversed().enumerated() {
                                            
                                            UIView.addKeyframe(withRelativeStartTime: stdTime * Double((time + 1)),
                                                               relativeDuration: stdTime,
                                                               animations: {
                                                                self.secondButtonArr[idx].transform = self.secondButtonArr[idx].transform.scaledBy(x: UIValue.minScale.rawValue , y: UIValue.minScale.rawValue)
                                                                let moveButtons = self.secondButtonArr[idx...self.secondButtonArr.count-1]
                                                                moveButtons.forEach{ $0.center.y += UIValue.distance.rawValue * CGFloat(1) }
                                            })
                                        }
                                        
                                    }
        })
    }


}


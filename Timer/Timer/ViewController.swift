//
//  ViewController.swift
//  Timer
//
//  Created by chang sic jung on 03/07/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer?
    
    lazy var lblTimeCheck: UILabel = {
        let lb = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 50, y: 300, width: 100, height: 60))
        lb.layer.cornerRadius = 8
        lb.layer.borderColor = UIColor.black.cgColor
        lb.layer.borderWidth = 2
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 20, weight: .light)
        lb.text = "타임 오버"
        lb.alpha = 0
        
        view.addSubview(lb)
        return lb
    }()
    
    lazy var lblTimer: UILabel = {
        let lb = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 50, y: 200, width: 100, height: 60))
        lb.backgroundColor = .yellow
        lb.layer.cornerRadius = 8
        lb.layer.borderColor = UIColor.black.cgColor
        lb.layer.borderWidth = 2
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 20, weight: .light)
        lb.text = "30"
        
        view.addSubview(lb)
        return lb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startCountDown()
    }

    func startCountDown() {
        lblTimer.text = "5"
        
        // 1초 마다 클로져를 실행시킨다.
        timer = Timer.scheduledTimer(withTimeInterval: 1,
                                     repeats: true)
        { [weak self] timer in
            guard let self = self else { return }
            
            let currentSeconds = Int((self.lblTimer.text ?? "0")) ?? 1
            
            guard currentSeconds > 0 else {
                timer.invalidate()
                print("이 부분에 카운트 끝낫을 때 실행될 코드")
                self.lblTimer.text = "0"
                UIView.animate(withDuration: 1, animations: {
                    self.lblTimeCheck.alpha = 1
                })
                
                return
            }
            
            self.lblTimer.text = "\(currentSeconds - 1)"
        }
    }
}


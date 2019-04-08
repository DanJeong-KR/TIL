//
//  ViewController.swift
//  Problem_Delegate2
//
//  Created by chang sic jung on 08/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

// 내가 만드는 델리게이트 패턴
// 위임 해주는 객체 : FirstViewController
// 위임 받는 객체 : SecondViewController
protocol FirstToSecondDelegate : class {
    func sendText_FirstToSecond(_ text: String)
}

class FirstViewController: UIViewController {
    
    weak var delegate: FirstToSecondDelegate? // 위임 해주는 애 쪽에 델리게이트 프로퍼티 만들기

    @IBOutlet weak var tf: UITextField!
    
    @IBOutlet weak var btPresent: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btPresent.addTarget(self, action: #selector(btAction(_:)), for: .touchUpInside)
    }
    
    
    // present 메소드로 delegate 쓰기.
    @objc func btAction(_ sender: Any?) {
        
        guard let second = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? SecondViewController else { return }
//
//
        
        //let second = SecondViewController()
        second.delegate = self
        //delegate = second
        //delegate?.sendText_FirstToSecond(tf.text ?? "")
        
        present(second, animated: true)
        
    }
    
    // segue 로 delegate 쓰기.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard
            let secondVC = segue.destination as? SecondViewController,
            let identifier = segue.identifier,
            let text = tf.text
                else { return }
        
        switch identifier {
        case "SecondToFirst":
            secondVC.delegate = self
        case "FirstToSecond":
            delegate = secondVC // 위임 해줄객체 delegate 에 설정해주기
            delegate?.sendText_FirstToSecond(text)
            // 위임 해주는 애가 원래 공통적으로 해주는 일.
            //위임 받는 아이가 이 메소드를 커스터마이징 할 떄는 매개변수인 text 를 활용해서 해야겠네.
        default:
            break
        }
 
        
        
        

    }
 


    @IBAction func unwindToFirstVC(_ unwindSegue: UIStoryboardSegue) {
        
    }
}

extension FirstViewController: SecondToFirstDelegate {
    func sendText_SecondToFirst() -> String {
        return tf.text ?? ""
    }
    
    
}

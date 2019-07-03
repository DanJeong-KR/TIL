//
//  FirstViewController.swift
//  NotificationCenterExample
//
//  Created by giftbot on 28/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class FirstViewController: UIViewController {
  
  @IBOutlet private weak var myTextField: UITextField!
  
    var temp: CGRect?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Swift 4.2+ UIResponder 로 발생시키는 객체가 뭔지 적어주게 됬다더라.
    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKeyBoardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKeyBoardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    temp = myTextField.frame
    
    NotificationCenter.default.addObserver(self, selector: #selector(testNoti(_:)), name:     UIApplication.didBecomeActiveNotification, object: nil)
    
    
    }
  
  @IBAction private func didEndOnExit(_ sender: Any) {}
    
    
    @objc func testNoti(_ noti: Notification) {
        print("didBecomeActiveNotification")
    }
    
    @objc func didReceiveKeyBoardNotification(_ noti: Notification) {
        
        guard let userInfo = noti.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }
        print(keyboardFrame)
        print("noti")
        
        UIView.animate(withDuration: duration) {
//            switch keyboardFrame.origin.y {
//            case 550:
//                self.myTextField.frame.origin.y = keyboardFrame.origin.y - 100
//            case 896:
//                self.myTextField.frame.origin.y = self.temp!.origin.y
//            default:
//                break
//            }
            
            if keyboardFrame.minY >= self.view.frame.maxY {
                self.myTextField.frame.origin.y += keyboardFrame.height
            }else {
                self.myTextField.frame.origin.y -= keyboardFrame.height
            }
        }
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

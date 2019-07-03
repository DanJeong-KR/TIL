//
//  ViewController.swift
//  AnimationPractice
//
//  Created by chang sic jung on 15/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var userIdTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var countDownLabel: UILabel!

    // MARK: - View LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userIdTextField.center.x -= userIdTextField.bounds.width
        passwordTextField.center.x -= passwordTextField.bounds.width
        loginButton.center.x -= loginButton.bounds.width
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6)
        {
            self.userIdTextField.center.x = self.userIdTextField.superview!.bounds.midX
        }
        
        UIView.animate(withDuration: 0.6,
                       delay: 0.5,
                       animations:
            {
                let midX = self.passwordTextField.superview!.bounds.midX
                self.passwordTextField.center.x = midX
        })
        
        UIView.animate(withDuration: 0.6,
                       delay: 1,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut],
                       animations:
            { self.loginButton.center.x = self.loginButton.superview!.bounds.midX }
        )
    }
    
    @IBAction private func login(_ sender: UIButton) {
        view.endEditing(true)
        
        loginButtonAnimation()
    }
    
    func loginButtonAnimation() {
        activityIndicatorView.startAnimating()
        
        let centerOrigin = loginButton.center
        
        UIView.animateKeyframes(withDuration: 1.6,
                                delay: 0,
                                options: [.repeat],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0.0,
                                                       relativeDuration: 0.25,
                                                       animations: {
                                                        self.loginButton.center.x += 50.0
                                                        self.loginButton.center.y += 20.0
                                    })
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                       relativeDuration: 0.25,
                                                       animations: {
                                                        self.loginButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
                                                        self.loginButton.center.x += 150.0
                                                        self.loginButton.center.y -= 70.0
                                                        self.loginButton.alpha = 0.0
                                    })
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.5,
                                                       relativeDuration: 0.01,
                                                       animations: {
                                                        self.loginButton.transform = .identity
                                                        self.loginButton.center = CGPoint(x: centerOrigin.x, y: self.loginButton.superview!.frame.height + 120)
                                    })
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.75,
                                                       relativeDuration: 0.25,
                                                       animations: {
                                                        self.loginButton.alpha = 1.0
                                                        self.loginButton.center = centerOrigin
                                    })
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 0.25, animations: {
                                        self.loginButton.center.y = self.loginButton.frame.maxY - 120
                                    })
                                    
                                    
        },
                                completion: {
                                    _ in
                                    self.activityIndicatorView.stopAnimating()
        })
    }

    

}


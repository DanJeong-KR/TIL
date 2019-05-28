//
//  ContentViewController.swift
//  StatusBarAndHomeIndicatorExample
//
//  Created by giftbot on 2019. 5. 28..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ContentViewController: UIViewController {
  
  private var statusBarStyle = UIStatusBarStyle.default
  private var isStatusBarHidden = false
  private var isHomeIndicatorAutoHidden = false
  
  // MARK: StatusBar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle // statusBarStyle 가 변하면 바뀔 수 있도록.
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
  
  // MARK: HomeIndicator
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return isHomeIndicatorAutoHidden
    }
  
  
  // MARK: Action Handler
  
  @IBAction private func toggleStatusBarStyle(_ sender: Any) {
    let isDefault = statusBarStyle == .default
    
    statusBarStyle = isDefault ? .lightContent : .default
    UIView.animate(withDuration: 0.5) {
        self.view.backgroundColor = !isDefault ? .white : .darkGray
        self.setNeedsStatusBarAppearanceUpdate() // 흰색으로 바뀌어서 배경색과 같아져서 안보읻게 됨
    }
  }
  
  @IBAction private func toggleStatusBarHidden(_ sender: Any) {
    
    isStatusBarHidden.toggle()
    UIView.animate(withDuration: 0.5) {
        self.setNeedsStatusBarAppearanceUpdate()
    }
  }
  
  @IBAction private func toggleHomeIndicatorHidden(_ sender: Any) {
    
    isHomeIndicatorAutoHidden.toggle()
    setNeedsUpdateOfHomeIndicatorAutoHidden()
    // 손을 가져다 대면 나타나고, 아닐때 없어지는 효과
  }
}

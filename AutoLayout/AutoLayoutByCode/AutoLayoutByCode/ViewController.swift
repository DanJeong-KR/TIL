//
//  ViewController.swift
//  AutoLayoutByCode
//
//  Created by giftbot on 2018. 6. 18..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  private let firstView = UIView()
  private let secondView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    firstView.backgroundColor = .darkGray
    view.addSubview(firstView)
    secondView.backgroundColor = .green
    firstView.addSubview(secondView)
    
//    setupAutoresizingMask()
    activateLayoutAnchors()
    
    // NSLayoutConstraint, VisualFormat 참고용
//    activateNSLayoutConstraintConstraints()
//    activateVisualFormat()
  }
  
  private func setupAutoresizingMask() {
    firstView.frame = CGRect(x: 50, y: 50, width: view.bounds.width - 100, height: view.bounds.height - 100)
    secondView.frame = CGRect(x: 40, y: 40, width: firstView.bounds.width - 80, height: firstView.bounds.height - 80)
    
    firstView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    secondView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  private func activateLayoutAnchors() {
    // iOS 9.0 이상
    firstView.translatesAutoresizingMaskIntoConstraints = false
    firstView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
    firstView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
    
    
    secondView.translatesAutoresizingMaskIntoConstraints  = false
    secondView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 40).isActive = true
    secondView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 40).isActive = true
    secondView.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -40).isActive = true
    secondView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -40).isActive = true
  }
}



// MARK: - NSLayoutConstraint, VisualFormat

extension ViewController {
  private func activateNSLayoutConstraintConstraints() {
    firstView.translatesAutoresizingMaskIntoConstraints  = false
    secondView.translatesAutoresizingMaskIntoConstraints  = false
    
    // FirstView <-> View
    NSLayoutConstraint(
      item: firstView,
      attribute: .top,
      relatedBy: .equal,
      toItem: view,
      attribute: .top,
      multiplier: 1,
      constant: 50
      ).isActive = true
    
    NSLayoutConstraint(item: firstView, attribute: .leading,
                       relatedBy: .equal,
                       toItem: view, attribute: .leading,
                       multiplier: 1, constant: 50).isActive = true
    
    NSLayoutConstraint(item: firstView, attribute: .bottom,
                       relatedBy: .equal,
                       toItem: view, attribute: .bottom,
                       multiplier: 1, constant: -50).isActive = true
    
    NSLayoutConstraint(item: firstView, attribute: .trailing,
                       relatedBy: .equal,
                       toItem: view, attribute: .trailing,
                       multiplier: 1, constant: -50).isActive = true
    
    
    // SecondView <-> FirstView
    NSLayoutConstraint(item: secondView, attribute: .top, relatedBy: .equal, toItem: firstView, attribute: .top, multiplier: 1, constant: 40).isActive = true
    NSLayoutConstraint(item: secondView, attribute: .leading, relatedBy: .equal, toItem: firstView, attribute: .leading, multiplier: 1, constant: 40).isActive = true
    NSLayoutConstraint(item: secondView, attribute: .bottom, relatedBy: .equal, toItem: firstView, attribute: .bottom, multiplier: 1, constant: -40).isActive = true
    NSLayoutConstraint(item: secondView, attribute: .trailing, relatedBy: .equal, toItem: firstView, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
    
    /***************************************************
     iOS 6.0 부터 사용된 firstView.addConstraint(<#T##constraint: NSLayoutConstraint##NSLayoutConstraint#>) 같은 메서드가 있으나
     iOS 8.0 부터 나온 isActive 프로퍼티를 이용해 constraint 를 추가하거나 제거하는 것이 권장됨
     ***************************************************/
  }
  
  
  private func activateVisualFormat() {
    /***************************************************
     Visual Format Syntax
     https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html
     ***************************************************/
    
    firstView.translatesAutoresizingMaskIntoConstraints = false
    secondView.translatesAutoresizingMaskIntoConstraints = false
    
    let views: [String: Any] = ["firstView": firstView, "secondView": secondView]
    let metrics: [String: Any] = ["margin": 50, "padding": 40]
    let visualFormats: [String] = [
      "H:|-margin-[firstView]-margin-|",
      "V:|-margin-[firstView]-margin-|",
      "H:|-padding-[secondView]-padding-|",
      "V:|-padding-[secondView]-padding-|",
    ]
    
    var allConstraints: [NSLayoutConstraint] = []
    for visualFormat in visualFormats {
      allConstraints += NSLayoutConstraint.constraints(
        withVisualFormat: visualFormat,
        metrics: metrics,
        views: views
      )
    }
    NSLayoutConstraint.activate(allConstraints)
  }

}

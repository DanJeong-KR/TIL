//
//  ViewController.swift
//  FoldingMenusExample
//
//  Created by giftbot on 2019. 5. 16..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  private struct Time {
    static let short = 0.3
    static let middle = 0.65
    static let long = 1.0
  }
  
  private struct UI {
    static let menuCount = 5
    static let menuSize: CGFloat = 60
    static let distance: CGFloat = 130
    static let minScale: CGFloat = 0.3
  }
  
  private var firstMenuContainer: [UIButton] = []
  private var secondMenuContainer: [UIButton] = []
  
  // MARK: - Setup UI
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupFirstMenu()
    setupSecondMenu()
  }
  
  private func randomColorGenerator() -> UIColor {
    let red = CGFloat.random(in: 0...1.0)
    let green = CGFloat.random(in: 0...1.0)
    let blue = CGFloat.random(in: 0...1.0)
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
  }
  
  private func makeMenuButton(with frame: CGRect, title: String) -> UIButton {
    let button = UIButton(frame: frame)
    button.backgroundColor = randomColorGenerator()
    button.setTitle(title, for: .normal)
    button.layer.cornerRadius = button.bounds.width / 2
    button.transform = button.transform.scaledBy(x: UI.minScale, y: UI.minScale)
    view.addSubview(button)
    return button
  }
  
  private func setupFirstMenu() {
    for i in (0..<UI.menuCount) {
      let menuFrame = CGRect(
        x: 50, y: view.bounds.height - 120,
        width: UI.menuSize, height: UI.menuSize
      )
      let button = makeMenuButton(with: menuFrame, title: "버튼 \(i)")
      firstMenuContainer.append(button)
      
      if i == 0 {
        button.transform = .identity
        button.addTarget(self, action: #selector(firstMenuDidTap(_:)), for: .touchUpInside)
      }
    }
    view.bringSubviewToFront(firstMenuContainer.first!)
  }
  
  private func setupSecondMenu() {
    for i in (0..<UI.menuCount) {
      let menuFrame = CGRect(
        x: view.bounds.width - 50 - UI.menuSize, y: view.bounds.height - 120,
        width: UI.menuSize, height: UI.menuSize
      )
      let button = makeMenuButton(with: menuFrame, title: "버튼\(i)")
      secondMenuContainer.append(button)
      
      if i == 0 {
        button.transform = .identity
        button.addTarget(self, action: #selector(secondMenuDidTap(_:)), for: .touchUpInside)
      }
    }
    view.bringSubviewToFront(secondMenuContainer.first!)
  }
  
  
  
  // MARK: - ActionHandler
  
  @objc private func firstMenuDidTap(_ button: UIButton) {
    print("---------- [ usingSpringWithDamping ] ----------\n")
    button.isSelected.toggle()
    
    UIView.animate(
      withDuration: Time.middle,
      delay: 0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 0.0,
      animations: {
        for (idx, menu) in self.firstMenuContainer.enumerated() {
          guard idx != 0 else { continue }
          if button.isSelected {
            menu.transform = .identity
            menu.center.y -= UI.distance * CGFloat(idx)
          } else {
            menu.transform = menu.transform.scaledBy(x: UI.minScale, y: UI.minScale)
            menu.center.y += UI.distance * CGFloat(idx)
          }
        }
    })
  }
  
  @objc private func secondMenuDidTap(_ button: UIButton) {
    print("---------- [ animateKeyframes ] ----------\n")
    button.isSelected.toggle()
    var startTime = 0.0
    var duration = 1.0 / Double(UI.menuCount)
    
    UIView.animateKeyframes(
      withDuration: Time.middle,
      delay: 0,
      options: [.beginFromCurrentState],
      animations: {
        for i in 1..<UI.menuCount {
          defer { startTime += duration }
          UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration, animations: {
            if button.isSelected {
              self.secondMenuContainer[i].transform = .identity
//              self.secondMenuContainer[i].transform = CGAffineTransform(translationX: CGFloat(-30 * i), y: 0)
              
              self.secondMenuContainer.enumerated()
                .filter { $0.offset >= i }
                .forEach { $0.element.center.y -= UI.distance }
            } else {
              let minScaleTransform = CGAffineTransform(scaleX: UI.minScale, y: UI.minScale)
              self.secondMenuContainer[UI.menuCount - i].transform = minScaleTransform
              self.secondMenuContainer.enumerated()
                .filter { $0.offset >= UI.menuCount - i }
                .forEach { $0.element.center.y += UI.distance }
            }
          })
        }
    })
  }
  
}

//
//  ViewController.swift
//  ScrollViewExample
//
//  Created by giftbot on 2018. 6. 18..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit


final class ViewController: UIViewController {

  // MARK: Properties
  
  @IBOutlet private weak var scrollView: UIScrollView!
  @IBOutlet private weak var imageView: UIImageView!
    
    var zoomScale: CGFloat = 1 {
        didSet {
            print("현재 줌 스케일 : ", String(format: "%.2f", zoomScale))
        }
    }
    
    var moveRight = 0 {
        didSet {
            print("현재 화면의 x 좌표는 : ", String(moveRight))
        }
    }
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.delegate = self
    updateScrollViewZoomScale()
    
  }
    
    func updateScrollViewZoomScale() {
        let widthScale = view.bounds.width / imageView.bounds.width
        let heightScale = view.bounds.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale // 최소 배율만 설정하고
        scrollView.zoomScale = 1 // 현재 배율은 1로 하고
        scrollView.maximumZoomScale = 6
    }
  
  // MARK: Action Handler
  
  @IBAction private func fitToWidth(_ sender: Any) {
    print("\n---------- [ fitToWidth ] ----------")
    
    zoomScale = scrollView.frame.width / imageView.image!.size.width
    // 이미지 크기가 3배면 0.33 이 나옴. 곱하면 화면에 꽉 차겠지
    scrollView.setZoomScale(zoomScale, animated: true)
    
  }
  
  @IBAction private func scaleDouble(_ sender: Any) {
    print("\n---------- [ scaleDouble ] ----------")
    
//    zoomScale *= 2
//    scrollView.setZoomScale(zoomScale, animated: true)
    
    scrollView.setZoomScale(zoomScale*2, animated: true)
    zoomScale = scrollView.zoomScale
    // 이렇게 설정해야 내가 설정한 최대 줌 스케일 이상으로 올라갈 시 zoomScale 변수가 바뀌지 않는다.
  }

  @IBAction private func moveContentToRight(_ sender: Any) {
    print("\n---------- [ moveContentToRight ] ----------")
    
    // 우측으로 150 만큼 이동해라
//    moveRight += 150
//    scrollView.setContentOffset(CGPoint(x: moveRight, y: 0), animated: true)
    
    scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x+150, y: scrollView.contentOffset.y), animated: true)
    
  }
}


extension ViewController: UIScrollViewDelegate {
    
    // 어떤 객체에 zoom 을 적용할 것인지 지정을 해줘야 한다.
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

extension UIScrollView {
    
}

//
//  Extention.swift
//  URLSessionPractice
//
//  Created by Wi on 10/06/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingLeft: CGFloat,
                paddingBottom: CGFloat,
                paddingRight: CGFloat,
                width: CGFloat,
                height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func zoomIn(duration duration: TimeInterval = 0.2) {
        self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (animationCompleted: Bool) -> Void in
        }
    }
}


// 이미지가 캐쉬 되도록
// Kingfisher 라이브러리가 이미지 캐쉬 해줘

var imageCache = [String: UIImage]()

extension UIImageView {
    
    // 네트워크로 이미지 받을 때
    func loadImage(with urlString: String) {
        
        self.image = nil
        
        guard let url = URL(string: urlString) else { return }
        
        // url 에 대한 키값이 존재하면
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        // 데이터 요청
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // error
            if let error = error {
                print(error.localizedDescription)
            }
            guard let imageData = data else { return }
            
            // 이미지 넣기
            let photoImage = UIImage(data: imageData)
            // 이미지 url : UIImage 헝태로 캐시에 저장해놓자
            imageCache[urlString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
    }
}

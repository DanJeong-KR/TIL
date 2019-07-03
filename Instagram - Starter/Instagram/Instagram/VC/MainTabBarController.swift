//
//  MainViewController.swift
//  Instagram
//
//  Created by Wi on 29/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: - Properties
    let picker = UIImagePickerController()
    let noti = NotificationCenter.default
    
    let homeVC = HomeViewController()
    let plusVC = PlusViewController()
    let myVC = MyViewController()
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageData.homeNomal), selectedImage: UIImage(named: AppImageData.homeSelected))
        plusVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageData.plus), selectedImage: nil)
        myVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "pica"),selectedImage: nil)

        
        viewControllers = [
            UINavigationController(rootViewController:homeVC),
            plusVC,
            UINavigationController(rootViewController: myVC),
        ]
        
        // 탭바 위치 설정
//        for i in tabBar.items! {
//            i.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
//        }
        
        picker.delegate = self
        delegate = self
    }
    
    // 탭바를 선택했을때 불릴 함수 입니다.
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if type(of: viewController) == PlusViewController.self {
            picker.sourceType = .photoLibrary
            present(picker, animated: true)
            return false // 탭바의 + 부분은 버튼형식으로 사용할 거라서 선택되지 않게 return false 해준다.
        }
        return true
    }
}

extension MainTabBarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {print("imageError"); return }
        
        noti.post(name: NSNotification.Name("LibraryImagePicked"), object: nil, userInfo: ["image" : image ])
        
        picker.dismiss(animated: true)
    }
}

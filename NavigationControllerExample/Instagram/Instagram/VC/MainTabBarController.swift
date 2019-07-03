

import UIKit

class MainTabBarController: UITabBarController {
    
    let picker = UIImagePickerController()
    
    let homeVC = HomeViewController()
    let plusVC = PlusViewController()
    let myViewVC = MyViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        picker.delegate = self
        
        // 탭바 위에 뷰컨트롤러 올리기
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageData.homeNomal), selectedImage: UIImage(named: AppImageData.homeSelected))
        plusVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: AppImageData.plus), selectedImage: UIImage(named: AppImageData.plus))
        
        // homeVC에 네비게이션 적용시키기
        viewControllers = [UINavigationController.init(rootViewController: homeVC), plusVC,UINavigationController(rootViewController: myViewVC)]
        
        for i in tabBar.items! {
            i.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == plusVC {
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
            return false
        }
        return true
    }
}

extension MainTabBarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        NotificationCenter.default.post(name: NSNotification.Name("photoSelected"), object: nil, userInfo: ["image" : info[.originalImage]])
        
        picker.dismiss(animated: true, completion: nil)
    }
}

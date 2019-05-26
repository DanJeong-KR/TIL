//
//  MyViewController.swift
//  Instagram
//
//  Created by Wi on 03/05/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit


// 닉네임과 프로필 이미지를 변경하게 될 컨트롤러 입니다.
// 여기서 닉네임과 프로필 이미지를 변경한 다음 부터는 피드를 추가할때 등록된 닉네임과 프로필 이미지로 피드가 등록되어야 합니다.
// 닉네임 중복검사는 선택사항입니다. 
// 기본 값이 UITableViewController 입니다. 기본 뷰컨트롤러로 구현하고 싶으시면 타입을 UIViewController로 바꿔주세요.

class MyViewController: UITableViewController {
    
    var user: User?
    let userManager = UserManager.shared
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MyViewTableViewCell", bundle: nil), forCellReuseIdentifier: "MyViewTableViewCell")
        tableView.separatorColor = .clear
        
        picker.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeProfileBtnDidTap(_:)), name: NSNotification.Name("changeProfileBtnDidTap"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(profileImageDidTapped(_:)), name: NSNotification.Name(rawValue: "imageViewDidTapped"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewwillappear")
        user = userManager.getUserData()
        print(user)
        tableView.reloadData()
    }
    
    private func profileImnageAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "카메라", style: .default) { _ in
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true)
        }
        let photoAction = UIAlertAction(title: "앨범", style: .default) { (_) in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cameraAction)
        alert.addAction(photoAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    private func nikNameAlert(_ userInput: String) {
        guard !userInput.isEmpty else { print("별명을 입력하세요");return }
        let alert = UIAlertController(title: nil, message:userInput , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
            self.userManager.setUserNickName(nickName: userInput)
            
            self.user = self.userManager.getUserData()
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
    
    // MARK: - 버튼 액션 메소드들
    @objc private func changeProfileBtnDidTap(_ sender: Notification) {
        
        guard let userInfo = sender.userInfo as? [String : String],
        let nikNameText = userInfo["nikNameText"] as? String
            else { return }
        nikNameAlert(nikNameText)
    }
    
    @objc private func profileImageDidTapped(_ sender: Notification) {
        profileImnageAlert()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyViewTableViewCell", for: indexPath) as! MyViewTableViewCell
        //cell.model = user
        cell.model = user
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension MyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        userManager.setUserProfileImage(profileImage: image)
        picker.dismiss(animated:true)
    }
}

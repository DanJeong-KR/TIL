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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = UserManager.shared.getUserData()
        
        tableView.register(UINib(nibName: "MyViewTableViewCell", bundle: nil), forCellReuseIdentifier: "MyViewTableViewCell")
        tableView.separatorColor = .clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeProfileBtnDidTap(_:)), name: NSNotification.Name("changeProfileBtnDidTap"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = UserManager.shared.getUserData()
        tableView.reloadData()
    }
    
    
    @objc private func changeProfileBtnDidTap(_ sender: Notification) {
        
        guard let userInfo = sender.userInfo as? [String : String],
        let nikNameText = userInfo["nikNameText"] as? String
            else { return }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyViewTableViewCell", for: indexPath) as! MyViewTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

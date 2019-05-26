//
//  AddFeedViewController.swift
//  Instagram
//
//  Created by Wi on 30/04/2019.
//  Copyright © 2019 Wi. All rights reserved.


import UIKit

// 카메라로 사진을 찍거나 앨범에서 사진을 선택할 시에 오게될 컨트롤러입니다.
// 오른쪽 상단에 공유버튼을 올리고 공유를 누르면 Feed를 추가합니다.
// 기본 값이 UITableViewController 입니다.
// 기본 뷰컨트롤러로 구현하고 싶으시면 타입을 UIViewController로 바꿔주세요.

class AddFeedViewController: UITableViewController {
    
    var receivedImage: UIImage?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = UserManager.shared.getUserData()
    }
    
    private func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "공유", style: .done, target: self, action: #selector(shareBtnDidTapped(_:)))
        
        title = "새 게시물"
        tableView.register(UINib(nibName: "AddFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "AddFeedTableViewCell")
    }
    
    @objc private func shareBtnDidTapped(_ sender: Any) {
        
        guard let storyText = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddFeedTableViewCell).textView.text,
        let receivedImage = receivedImage else { return }
        
        let feedData = FeedData(profileImage: user?.profileImage, nikName: user?.nikName, feedImage: receivedImage, myStory: storyText)
        FeedManager.shared.addFeedDatas(feedData)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddFeedTableViewCell", for: indexPath) as! AddFeedTableViewCell
        
        cell.feedImageView.image = receivedImage
        
        return cell
    }

}


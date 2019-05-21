//
//  CommentViewController.swift
//  Instagram
//
//  Created by Wi on 23/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

// HomeVC에서 보여주는 FeedData에서 댓글 버튼을 누르면 나올 컨트롤러입니다.
// 각각의 FeedData 에 각각의 댓글을 보여줍니다.
// 이모티콘 버튼은 선택사항입니다.

class CommentViewController: UIViewController{
    
    let emojiSelectionView = EmojiSelectionView()
    let tableView = UITableView()
    
    var feedInfo: FeedData!
    var commentArr: [String?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        // 속성들 설정하기
        title = "댓글"
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        notifications()
        commentArr = feedInfo.comments
        // add subview 했어?
        view.addSubviews([emojiSelectionView, tableView])
        // delegate 있어?
        tableView.dataSource = self
        // layout 설정 했어?
        autolayouts()
    }
    
    private func notifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(commentBtnDidTapped(_:)), name: NSNotification.Name("commentBtnDidTapped"), object: nil)
    }
    
    private func autolayouts() {
        tableView.layout.top().leading().trailing()
        emojiSelectionView.layout.leading().trailing().bottom().top(equalTo: tableView.bottomAnchor)
        emojiSelectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2 ).isActive = true
    }
    
    @objc private func keyboardWillShowNotification(_ sender: Notification) {
        guard let userInfo = sender.userInfo,
            let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let keyboardDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let keyboardHeight = keyboardEndFrame.height
        
        UIView.animate(withDuration: keyboardDuration) {
            self.emojiSelectionView.bottom(equalTo: self.view.bottomAnchor, constant: -keyboardHeight)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func commentBtnDidTapped(_ sender: Notification) {
        // 데이터 모델에 데이터 주고 테이블 리로드 시켜서
        guard let userInfo = sender.userInfo as? [String : String],
            let text = userInfo["text"] as? String
            else { return }
        
        feedInfo.comments.append(text)
        
        tableView.reloadData()
        
    }
}

extension CommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedInfo.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        cell.feedNickNameLabel.text = feedInfo.nikName
        cell.feedImageView.image = feedInfo.profileImage
        cell.feedComment.text = feedInfo.comments[indexPath.row]
        return cell
    }


}


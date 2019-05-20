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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        // 속성들 설정하기
        title = "댓글"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //tableView.frame.size.height = CGFloat(500)
        // add subview 했어?
        view.addSubviews([emojiSelectionView, tableView])
        view.bringSubviewToFront(emojiSelectionView)
        // delegate 있어?
        //tableView.dataSource = self
        // layout 설정 했어?
        autolayouts()
    }
    
    private func autolayouts() {
        tableView.layout.top().leading().trailing().bottom()
        emojiSelectionView.layout.leading().trailing().bottom()
        emojiSelectionView.heightAnchor.constraint(equalTo: tableView.heightAnchor,multiplier: 0.2 ).isActive = true
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
}

//extension CommentViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return
//    }
//
//
//}


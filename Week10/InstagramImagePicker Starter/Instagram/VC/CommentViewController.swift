//
//  CommentViewController.swift
//  Instagram
//
//  Created by Wi on 23/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITableViewDataSource {
    
    var feedData: FeedData?
    
    var inputTextView = InputCommentView()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "comment")
        
        NotificationCenter.default.addObserver(self, selector: #selector(addComment), name: NSNotification.Name("addCommentDidTap"), object: nil)
        keyboardSetting()
        view.addSubview(inputTextView)
        view.addSubview(tableView)
        autolayout()
        
        naviSetting()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    func naviSetting(){
        self.navigationItem.title = "댓글"
    }
    func keyboardSetting(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func addComment(){
        self.feedData?.comment?.append(inputTextView.textField.text!)
        self.tableView.reloadData()
    }
    
    @objc private func keyboardWillHide(_ sender: Notification){
        self.view.frame.origin.y = 0
    }
    
    @objc private func keyboardWillShow(_ sender: Notification){
        self.view.frame.origin.y = -250
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.inputTextView.textField.resignFirstResponder()
    }
    
    func autolayout(){
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        self.inputTextView.topAnchor.constraint(equalTo: self.tableView.bottomAnchor).isActive = true
        self.inputTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.inputTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.inputTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.inputTextView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData?.comment?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! CommentTableViewCell
        cell.feedNickNameLabel.text = feedData?.nickName
        cell.feedImageView.image = feedData?.feedImage
        cell.feedComment.text = feedData?.comment?[indexPath.row]
        return cell
        
    }

}

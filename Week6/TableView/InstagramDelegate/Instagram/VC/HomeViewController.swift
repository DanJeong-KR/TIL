//
//  ViewController.swift
//  Instagram
//
//  Created by Wi on 11/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let commentVC = CommentViewController()
    // MARK: - Properties
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var feedDataArr = [FeedData]() // 서버가 이 데이터 줌.
    
    var commentButtonFlag = false
    
    // MARK: - Methods
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: other func
    
    func configure(){
        // create dataArr
        createFeedData()
        
        // navigation item setting
        naviSetting()
        
         //tableViewSetting
        tableViewRegister()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        
        // addSubView
        view.addSubview(tableView)
        
        // autolayout
        autoLayout()
    }
    
    func createFeedData() {
        for i in 1...4 {
            let feedData = FeedData(profileImage: AppImageData.profile + "\(i)", nickName: "User\(i)", feedImage: AppImageData.feedImage + "\(i)")
            FeedManager.shared.addFeedData(feedData)
        }
        
        let me = FeedData(profileImage: AppImageData.profile + "4", nickName: "ChangSikkk", feedImage: "feedImage4")
        FeedManager.shared.addFeedData(me)
        
        feedDataArr = FeedManager.shared.returnFeedData()
    }
    
    
    func tableViewRegister() {
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "Feed")
    }
    
    
    func naviSetting(){
        let naviTitleView = UIImageView(image: UIImage(named: AppImageData.logo))
        naviTitleView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = naviTitleView
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: AppImageData.camera), style: .plain, target: self, action: #selector(cameraButtonDidTap(_:))), animated: true)
    }
    
    // MARK: Action
    @objc private func cameraButtonDidTap(_ sender: UIBarButtonItem){
        print("camera Button Tap")
    }
    
    // MARK: AutoLayout
    func autoLayout(){
        let guide = self.view.safeAreaLayoutGuide
        
        self.tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }

}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Feed", for: indexPath) as! FeedTableViewCell
        cell.delegate = self
        
        tableView.rowHeight = cell.frame.height
        
        // 컨트롤러가 셀에 데이터를 줘야 한다.
        cell.model = feedDataArr[indexPath.row]
        
        
        return cell
    }
}

//MARK: -FeedTableViewCellDelegate
extension HomeViewController: FeedTableViewCellDelegate {
    func sendButtonInfo(cell: FeedTableViewCell) {
        
        let indexpath = tableView.indexPath(for: cell)
        commentVC.feedData = feedDataArr[indexpath!.row]
      
        navigationController?.pushViewController(commentVC, animated: true)
    
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}


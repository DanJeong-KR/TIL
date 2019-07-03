//
//  ViewController.swift
//  Instagram
//
//  Created by Wi on 11/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

// 피드데이터를 보여줄 컨트롤러 입니다.
// 왼쪽 상단에 카메라 버튼이 있습니다.

class HomeViewController: UIViewController {
    
    let tableView = UITableView()
    let imgView = UIImageView(image: UIImage(named: AppImageData.logo))
    
    let picker = UIImagePickerController()
    let noti = NotificationCenter.default
    
    private var feedDataArr: [FeedData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        tableviewConfigure()
        notificationObservers()
        
        autolayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        feedDataArr = FeedManager.shared.getFeedDatas()
        tableView.reloadData()
    }
    
    private func configure() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: AppImageData.camera)
            , style: .done,
              target: self,
              action: #selector(cameraBtnDidTapped(_:)))
        
        navigationItem.titleView = imgView
        
        imgView.contentMode = .scaleAspectFit
        picker.delegate = self
        
    }
    private func tableviewConfigure() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        
        feedDataArr = FeedManager.shared.getFeedDatas()
    }
    
    // MARK: - Notification 관련 함수
    private func notificationObservers() {
        noti.addObserver(self, selector: #selector(LibraryImagePicked(_:)), name: NSNotification.Name("LibraryImagePicked"), object: nil)
        noti.addObserver(self, selector: #selector(commentButtonDidTap(_:)), name: NSNotification.Name("commentButtonDidTap"), object: nil)
    }
    
    @objc private func LibraryImagePicked(_ sender: Notification){
        let vc = AddFeedViewController()
        guard let userInfo = sender.userInfo as? [String : Any],
        let pickedImage = userInfo["image"] as? UIImage
        else { return }
        vc.receivedImage = pickedImage
        
        show(vc, sender: nil)
    }
    
    @objc private func commentButtonDidTap(_ sender: Notification) {
        guard let sender = sender.userInfo as? [String : FeedData],
            let selectedFeedInfo = sender["feedInfo"] as? FeedData
            else { return }
        let vc = CommentViewController()
        vc.feedInfo = selectedFeedInfo
        show(vc, sender: nil)
    }
    
    // MARK: - 오토레이아웃
    private func autolayouts() {
        tableView.layout.top().bottom().leading().trailing()
    }
    
    // MARK: - 카메라 버튼 액션
    @objc private func cameraBtnDidTapped(_ sender: Any) {
        picker.sourceType = .camera
        present(picker, animated: true)
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        //noti.post(name: NSNotification.Name(rawValue: "cameraImageDidPicked"), object: nil, userInfo: ["image" : pickedImage])
        
        let addVC = AddFeedViewController()
        addVC.receivedImage = pickedImage
        show(addVC, sender: nil)
        picker.dismiss(animated: true)
    }
    
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        cell.feedData = feedDataArr[indexPath.row]
        
        return cell
    }
}

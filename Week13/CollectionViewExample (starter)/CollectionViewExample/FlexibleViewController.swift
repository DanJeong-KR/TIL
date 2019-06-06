//
//  FlexibleViewController.swift
//  CollectionViewExample
//
//  Created by giftbot on 30/05/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit



final class FlexibleViewController: UIViewController {
    
    private enum UI {
        static let itemsInLine: CGFloat = 3 // 한 줄에 몇개씩 있을건지 결정하기
        static let linesOnScreen: CGFloat = 5 // 스크린에 라인이 몇개 있을 건지 결정하기
        static let itemSpacing: CGFloat = 10.0
        static let lineSpacing: CGFloat = 10.0
        static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        static let nextOffset: CGFloat = 40 // 내가 원하는 것 말고 그 다음 셀에대한 길이
        
        // 과제
        // 1. linesOnScreen 속성 적용하기 // 원하는 줄 까지만 나오는 거
        // [도전과제]
        // 2. nextOffset 
    }
  
  let layout = UICollectionViewFlowLayout()
  lazy var collectionView = UICollectionView(frame: view.frame,
                                             collectionViewLayout: layout)
  var parkImages = ParkManager.imageNames(of: .nationalPark)
  
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupNavigationItem()
  }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupFlowLayout()
    }
  
  // MARK: Setup CollectionView
  
  func setupCollectionView() {
    collectionView.register(CustomCell.self,
                            forCellWithReuseIdentifier: CustomCell.identifier)
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    view.addSubview(collectionView)
    
    setupFlowLayout()
  }
  
  // MARK: Setup FlowLayout
  
  func setupFlowLayout() {
    layout.minimumLineSpacing = UI.lineSpacing
    layout.minimumInteritemSpacing = UI.itemSpacing
    layout.sectionInset = UI.edgeInsets
    
    let horizontalItemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
    let verticalItemSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
    
    let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
    
    //safe area 는 viewdidload 에서 0, 0, 0, 0 => viewSafeAreaInsetDidChange() 혹은 viewwilllayoutSubview  에서 해야함 (시점문제가 발생)
    let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom + view.safeAreaInsets.top + view.safeAreaInsets.bottom
    
    
    if layout.scrollDirection == .vertical { // 수직 방향 스크롤
        let horizontalSpacing = horizontalItemSpacing + horizontalInset
        let verticalSpacing = verticalItemSpacing + verticalInset
        
        let width = ((collectionView.frame.width - horizontalSpacing) / UI.itemsInLine).rounded(.down)
        let height = ((collectionView.frame.height - verticalSpacing) / UI.linesOnScreen).rounded(.down)
        
        layout.itemSize = CGSize(width: width, height: height)
    } else {
        let horizontalSpacing = verticalItemSpacing + horizontalInset
        let verticalSpacing = horizontalItemSpacing + verticalInset
        
        let width = ((collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen).rounded(.down)
        let height = ((collectionView.frame.height - verticalSpacing) / UI.itemsInLine).rounded(.down)
        
        
        layout.itemSize = CGSize(width: width, height: height)
    }
  }
  
  // MARK: Setup NavigationItem
  
  func setupNavigationItem() {
    let changeDirection = UIBarButtonItem(
      barButtonSystemItem: .reply,
      target: self,
      action: #selector(changeCollectionViewDirection(_:))
    )
    navigationItem.rightBarButtonItems = [changeDirection]
  }
  
  // MARK: - Action Handler
  
  @objc private func changeCollectionViewDirection(_ sender: Any) {
    let current = layout.scrollDirection
    
    layout.scrollDirection = (current == .horizontal) ? .vertical : .horizontal
    
    setupFlowLayout()
  }
  
}

// MARK: - UICollectionViewDataSource

extension FlexibleViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parkImages.count * 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CustomCell.identifier,
      for: indexPath
      ) as! CustomCell
    
    let item = indexPath.item % parkImages.count
    cell.configure(image: UIImage(named: parkImages[item]), title: parkImages[item])
    cell.backgroundColor = .black
    
    return cell
  }
    
}




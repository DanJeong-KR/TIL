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
        static let itemsInLine: CGFloat = 3
        static let linesOnScreen: CGFloat = 5
        static let itemSpacing: CGFloat = 10.0
        static let lineSpacing: CGFloat = 10.0
        static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        static let nextOffset: CGFloat = 40
        
        // 1. linesOnScreen 속성 적용하기\\
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
    
    let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
    let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
    
    //safe area 는 viewdidload 에서 0, 0, 0, 0 => viewSafeAreaInsetDidChange() 혹은 viewwilllayoutSubview  에서 해야함 (시점문제가 발생)
    let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom + view.safeAreaInsets.top + view.safeAreaInsets.bottom
    
    
    if layout.scrollDirection == .vertical {
        let horizontalSpacing = itemSpacing + horizontalInset
        let width = (collectionView.frame.width - horizontalSpacing) / UI.itemsInLine
        
        let rounded = width.rounded(.down) // 소수점 내림
        layout.itemSize = CGSize(width: rounded, height: rounded)
    } else {
        let verticalSpacing = itemSpacing + verticalInset
        let height = (collectionView.frame.height - verticalSpacing) / UI.itemsInLine
        let rounded = height.rounded(.down)
        
        layout.itemSize = CGSize(width: rounded, height: rounded)
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




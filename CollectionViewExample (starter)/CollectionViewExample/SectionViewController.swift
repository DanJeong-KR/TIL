//
//  SectionViewController.swift
//  CollectionViewExample
//
//  Created by giftbot on 29/05/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class SectionViewController: UIViewController {
  
    let layout = UICollectionViewFlowLayout()
  lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
  let states = ParkManager.imageNames(of: .state)
  let parkList = ParkManager.list
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
  }
  
  func setupCollectionView() {
    //layout
    layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    layout.minimumLineSpacing = 15
    layout.minimumInteritemSpacing = 15
    layout.itemSize = CGSize(width: 170, height: 170)
    layout.headerReferenceSize = CGSize(width: 60, height: 60)
    layout.footerReferenceSize = CGSize(width: 50, height: 50)
    
    // 헤더 고정하기
    layout.sectionHeadersPinToVisibleBounds = true
    
    //collectionView
    collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
    
    collectionView.register(SectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooterView.identifier)
    
    collectionView.register(SectionCell.self, forCellWithReuseIdentifier: SectionCell.identifier)
    
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    view .addSubview(collectionView)
  }
}

// MARK: - UICollectionViewDataSource

extension SectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return states.count
    }
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parkList.filter { $0.location.rawValue == states[section]}.count * 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCell.identifier, for: indexPath
    ) as! SectionCell
    
    let parks = parkList.filter { $0.location.rawValue == states[indexPath.section]}
    let parkName = parks[indexPath.item % parks.count].name
    
    cell.configure(image: UIImage(named: parkName), title: parkName)
    
    return cell
  }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
            
            let state = states[indexPath.section]
            header.configure(image: UIImage(named: state), title: state)
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionFooterView.identifier, for: indexPath) as! SectionFooterView
            
            let count = parkList.filter{ $0.location.rawValue == states[indexPath.section]}.count * 2
            let title = "총 \(count)개 이미지"
            footer.configure(title: title)
            
            return footer
        }
        
        
        
        
    }
}


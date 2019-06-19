//
//  MenuView.swift
//  CustomCollectionView(like_TabBar)
//
//  Created by chang sic jung on 19/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class MenuView: UIView {
    let pageCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        
        return cv
    }()

    let menuBarView = MenuBarView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews([menuBarView,pageCollectionView])
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        configurePageCollectionView()
        print("didMoveToSuperview :",menuBarView.indicatorBar.frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCustomTabBar()
        print("layoutSubviews :",menuBarView.indicatorBar.frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureCustomTabBar() {
        menuBarView.delegate = self
        
        menuBarView.layout.leading().trailing().top()
        menuBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // 셀의 개수에 따라 indicatorBar 너비 정해지도록
        menuBarView.indicatorBar.widthAnchor.constraint(equalToConstant: self.frame.width / CGFloat(menuTitles.count)).isActive = true
    }
    
    private func configurePageCollectionView() {
        
        let collectionView = UICollectionView()
        
        //collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "menuCell")
        
        collectionView.register(cell: MenuCell.self)
        
        pageCollectionView.register(cell: MenuCell.self)
        
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        
        pageCollectionView.layout.top(equalTo: menuBarView.bottomAnchor).leading().trailing().bottom()
        
         //index 가 들어올 것을 예상을 하고 내가 할 일들을 작성한다.
        menuBarView.callBack = {[weak self] index in
            print("callback is working")
            self?.pageCollectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
        }
        
    }
}

extension MenuView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(MenuCell.self, indexPath)
        
        cell.label.text = menuTitles[indexPath.row]
        
        return cell
    }
    
    // MARK: - FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width,
                      height: self.frame.height - menuBarView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - Delegate
    
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            let itemAt = Int(targetContentOffset.pointee.x / self.frame.width)
            menuBarView.menuCollectionView.selectItem(at: IndexPath(item: itemAt, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // 계속 도는 애니까 애니메이션 처럼 보인다.
            menuBarView.indicatorBarLeadingConstraint.constant = scrollView.contentOffset.x / CGFloat(menuTitles.count)
        }
    
    
}

extension MenuView: menuBarDelegate {
    func menuBarDidSelected(_ indexPath: IndexPath) {
        pageCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

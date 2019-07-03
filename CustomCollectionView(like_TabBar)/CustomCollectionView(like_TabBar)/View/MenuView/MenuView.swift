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
        //cv.allowsSelection = false
        cv.backgroundColor = .white
        return cv
    }()

    let menuBarView = MenuBarView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews([menuBarView,pageCollectionView])
        configureCustomTabBar()
        configurePageCollectionView()
        
    }
    
    var isFirstCalled: Bool = false
    override func layoutSubviews() {
        super.layoutSubviews()
        // frame 값을 읽을 수 있는 시점이 여기뿐
        if !isFirstCalled {
            //menuBarView.indicatorBar.widthAnchor.constraint(equalToConstant: self.frame.width / CGFloat(menuTitles.count)).isActive = true
            
            pageCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            
            isFirstCalled = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureCustomTabBar() {
        menuBarView.delegate = self
        
        menuBarView.layout.leading(equalTo: leadingAnchor).trailing(equalTo: trailingAnchor).top(equalTo: topAnchor)
        menuBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    private func configurePageCollectionView() {
        
        pageCollectionView.register(cell: MenuCell.self)
        
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        
        pageCollectionView.layout.top(equalTo: menuBarView.bottomAnchor).leading(equalTo: leadingAnchor).trailing(equalTo: trailingAnchor).bottom(equalTo: bottomAnchor)
        
         //index 가 들어올 것을 예상을 하고 내가 할 일들을 작성한다.
        menuBarView.callBack = {[weak self] index in
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
        logger(targetContentOffset.pointee, velocity)
        let itemAt = Int(targetContentOffset.pointee.x / self.frame.width)
        menuBarView.menuCollectionView.selectItem(at: IndexPath(item: itemAt, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        pageCollectionView.selectItem(at: IndexPath(item: itemAt, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 계속 도는 애니까 애니메이션 처럼 보인다.
        menuBarView.indicatorBarLeadingConstraint.constant = scrollView.contentOffset.x / CGFloat(menuTitles.count)
    }
    
    
}

extension MenuView: MenuBarDelegate {
    func menuBarDidSelected(_ indexPath: IndexPath) {
        pageCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

//
//  MenuBar.swift
//  CustomCollectionView(like_TabBar)
//
//  Created by chang sic jung on 19/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class MenuBarView: UIView {
    // MARK: - Properties
    var delegate: MenuBarDelegate?
    
    let menuCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        
        return cv
    }()
    
    let indicatorBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    var callBack: ((IndexPath) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(menuCollectionView)
        addSubview(indicatorBar)
        
        configureCollectionView()
        //indicatorBarLeadingConstraint = indicatorBar.leadingAnchor.constraint(equalTo: leadingAnchor)
        configureContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private var isFirstCalled = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isFirstCalled {
            indicatorBar.widthAnchor.constraint(equalToConstant: self.frame.width / CGFloat(menuTitles.count)).isActive = true
            
            isFirstCalled = true
        }
    }
    
    
    private func configureCollectionView() {
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        
        menuCollectionView.register(cell: MenuCell.self)
    }
    
    var indicatorBarLeadingConstraint: NSLayoutConstraint!
    
    
    private func configureContraints() {
        if !isFirstCalled {
            menuCollectionView.layout.top(equalTo: topAnchor).bottom(equalTo: bottomAnchor).leading(equalTo: leadingAnchor).trailing(equalTo: trailingAnchor)
            
            // 변수에 담는다.
            //indicatorBar.leading()
            indicatorBarLeadingConstraint = indicatorBar.leadingAnchor.constraint(equalTo: leadingAnchor)
            indicatorBarLeadingConstraint.isActive = true
            
            indicatorBar.bottom(equalTo: bottomAnchor).heightAnchor.constraint(equalToConstant: 2).isActive = true
        }
    }
    
}

extension MenuBarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        return CGSize(width: self.frame.width / CGFloat(menuTitles.count), height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        delegate?.menuBarDidSelected(indexPath)
        
        guard let callback = callBack else {
            return
        }
        print("callback is working1")
        callback(indexPath)
        
        // 다이나믹 오토레이아웃 설정 값 적용하고
        self.indicatorBarLeadingConstraint.constant = (self.frame.width / CGFloat(menuTitles.count)) * CGFloat(indexPath.row)
        
        // 애니메이션 내부에서 runloop 에 알려줌.
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.layoutIfNeeded()
                        //self.setNeedsLayout()
        },
                       completion: nil)
    }
}


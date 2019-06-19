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
    var delegate: menuBarDelegate?
    
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
        
        indicatorBarLeadingConstraint = indicatorBar.leadingAnchor.constraint(equalTo: leadingAnchor)
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        configureCollectionView()
        //print("didMoveToSuperview",indicatorBar.frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureContraints()
        isFirstCalled = true
        
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    var indicatorBarLeadingConstraint: NSLayoutConstraint!
    
    var isFirstCalled: Bool = false
    
    private func configureContraints() {
        if !isFirstCalled {
            menuCollectionView.layout.top().bottom().leading().trailing()
            
            // 변수에 담는다.
            //indicatorBar.leading()
            indicatorBarLeadingConstraint = indicatorBar.leadingAnchor.constraint(equalTo: leadingAnchor)
            indicatorBarLeadingConstraint.isActive = true
            
            indicatorBar.bottom().heightAnchor.constraint(equalToConstant: 2).isActive = true
        }
    }
    
    private func configureCollectionView() {
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        
        menuCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        
    }
    
}

extension MenuBarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
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
        //print("didSelectItemAt")
        print("didSelectItemAt",indexPath.row)
        
        // 다이나믹 오토레이아웃 설정 값 적용하고
        self.indicatorBarLeadingConstraint.constant = (self.frame.width / CGFloat(menuTitles.count)) * CGFloat(indexPath.row)
        
//        delegate?.menuBarDidSelected(indexPath)
        guard let callback = callBack else {
            return
        }
        print("callback is working1")
        callback(indexPath)
        
        // 애니메이션 부분에서 runloop 에 알려줌.
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.layoutIfNeeded()
        },
                       completion: nil)
    }
}


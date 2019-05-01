//
//  SecondViewController.swift
//  DominoPractice
//
//  Created by chang sic jung on 01/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var dataDic: [String:[String]] = [:]
    let scrollView = UIScrollView()
    
    var dataArr:[UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuDatas.forEach { dataDic[$0.category] = $0.products.map { $0.name }}
        
        configure()
        autoLayout()
        
        dataDic.forEach {
            print("key값 :",$0.key)
            let sectionLabel = UILabel()
            self.scrollView.addSubview(sectionLabel)
            sectionLabel.text = $0.key
            sectionLabel.backgroundColor = .red
            sectionLabel.font = UIFont.boldSystemFont(ofSize: 25)
            sectionLabel.translatesAutoresizingMaskIntoConstraints = false
            if self.dataArr.count == 0 {
                NSLayoutConstraint.activate([
                    sectionLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                    sectionLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
                    sectionLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                    sectionLabel.heightAnchor.constraint(equalToConstant: 40),
                    sectionLabel.widthAnchor.constraint(equalToConstant: 414)
                    ])
            } else {
                NSLayoutConstraint.activate([
                    sectionLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                    sectionLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
                    sectionLabel.topAnchor.constraint(equalTo: self.dataArr[self.dataArr.count - 1].topAnchor ),
                    sectionLabel.widthAnchor.constraint(equalToConstant: 414),
                    sectionLabel.heightAnchor.constraint(equalToConstant: 40),
                    ])
            }
            dataArr.append(sectionLabel)
            ///////////////////////////
            dataDic[$0.key]?.forEach {
                print($0)
                let productLabel = UILabel()
                self.scrollView.addSubview(productLabel)
                productLabel.text = $0
                productLabel.backgroundColor = .yellow
                productLabel.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    productLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                    productLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
                    productLabel.topAnchor.constraint(equalTo: self.dataArr[self.dataArr.count - 1].topAnchor ),
                    productLabel.widthAnchor.constraint(equalToConstant: 414),
                    productLabel.heightAnchor.constraint(equalToConstant: 40),
                    ])
                dataArr.append(productLabel)
            }}
        
        dataArr.forEach { print("test :" + $0.text!) }
    }
    
    func configure() { view.addSubview(scrollView) }
    
    
    func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            ])
    }
}

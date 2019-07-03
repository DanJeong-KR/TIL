//
//  ViewController.swift
//  ScrollViewByCode
//
//  Created by chang sic jung on 13/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let yellowView = UIView()
    let redView = UIView()
    let greenView = UIView()
    let grayView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScrollView() // 스크롤 뷰 먼저 초기화
        
        setUpView()
        setUpAutoLayoutToViews()
        
    }
    
    func setUpScrollView() {
    
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
    }
    
    func setUpView() {
        yellowView.backgroundColor = .yellow
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        grayView.backgroundColor = .gray
        
        for i in [yellowView,redView,greenView,grayView] {
            scrollView.addSubview(i)
        }
    }
    
    func setUpAutoLayoutToViews() {
        // yellow View
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        yellowView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        yellowView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        yellowView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        yellowView.trailingAnchor.constraint(equalTo: redView.leadingAnchor).isActive = true
        yellowView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        yellowView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        
        // red View
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        redView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        redView.leadingAnchor.constraint(equalTo: yellowView.trailingAnchor).isActive = true
        redView.trailingAnchor.constraint(equalTo: greenView.leadingAnchor).isActive = true
        redView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        redView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        //green View
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        greenView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        greenView.leadingAnchor.constraint(equalTo: redView.trailingAnchor).isActive = true
        greenView.trailingAnchor.constraint(equalTo: grayView.leadingAnchor).isActive = true
        greenView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        greenView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        // gray View
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        grayView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        grayView.leadingAnchor.constraint(equalTo: greenView.trailingAnchor).isActive = true
        grayView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        grayView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        grayView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }

}


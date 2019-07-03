//
//  ViewController.swift
//  SlackNewWorkspace
//
//  Created by chang sic jung on 16/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

final class FirstViewController: UIViewController {
    
    private var newWorkspaceBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create New Workspace", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(createWorkspaceBtnAction(_:)), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configure()
        autolayouts()
        
    }
    
    private func configure() {
        view.addSubview(newWorkspaceBtn)
    }
    
    private func autolayouts() {
        newWorkspaceBtn.layout.centerX().centerY()
//        let guide = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//            newWorkspaceBtn.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
//            newWorkspaceBtn.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
//            ])
    }
    
    @objc private func createWorkspaceBtnAction(_ sender: UIButton) {
        
        let secondVC = UINavigationController(rootViewController: SecondViewController())
        
        show(secondVC, sender: nil)
        
    }
}


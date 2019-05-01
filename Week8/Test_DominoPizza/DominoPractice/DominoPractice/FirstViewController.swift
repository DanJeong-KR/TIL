//
//  ViewController.swift
//  DominoPractice
//
//  Created by chang sic jung on 01/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let tableView = UITableView()
    
    var dataDic: [String:[String]] = [:]
    var sectionTitle:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.sectionHeaderHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        autoLayout()
        
        //
        // 제일 중요한 것.
        
        for category in menuDatas {
            for product in category.products {
                if let _ = dataDic[category.category] {
                    dataDic[category.category]?.append(product.name)
                }else {
                    dataDic[category.category] = [product.name]
                }
            }
        }
        
//        menuDatas.forEach { dataDic[$0.category] = $0.products.map { $0.name } }
        sectionTitle = dataDic.keys.sorted()
    }
    
    private func autoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

extension FirstViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDic[sectionTitle[section]]!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataDic.keys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataDic[sectionTitle[indexPath.section]]?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
}

extension FirstViewController: UITableViewDelegate {
}

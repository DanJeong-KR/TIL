//
//  ProductViewController.swift
//  DominoPizzaExam
//
//  Created by Kira on 24/04/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

final class ProductViewController: UIViewController {
    
    var dataArr:[Pizza] = []
    
    var pizzaTitle: String = ""
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = pizzaTitle
        
        // 데이터 설정
        dataArr = DataManager.shared.returnData()[pizzaTitle]!
        
        tableViewSetup()
    }
    
    // MARK: - TableView setup
    func tableViewSetup() {
        view.addSubview(tableView)
        tableView.rowHeight = 120
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "product")
        
        // MARK: - AutoLayout 설정
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: guide.topAnchor)
            ])
    }
    
}

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductTableViewCell
        
        let value = dataArr[indexPath.row]
        cell.pizzaImageView.image = UIImage(named: value.name)
        cell.pizzaNameLabel.text = value.name
        cell.pizzaPriceLabel.text = String(value.price) + "원"
        
        return cell
    }
}


extension ProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        
        detailVC.pizzaTitle = pizzaTitle
        detailVC.pizzaName = dataArr[indexPath.row].name
        detailVC.pizzaIndex = indexPath.row
        
        show(detailVC, sender: nil)
    }
}

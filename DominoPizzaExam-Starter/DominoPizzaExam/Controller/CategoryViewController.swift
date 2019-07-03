//
//  ViewController.swift
//  DominoPizzaExam
//
//  Created by Kira on 24/04/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

// 헤더뷰에 도미노 피자 로고.
// 네비게이션 뷰 컨트롤러.
// 결제금액 의미없음.

import UIKit

final class CategoryViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView }()
    
    var dataArr:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Domino's"
        
        tableViewSetup()
        createPizzaData()
        
        dataArr = DataManager.shared.returnPizzaTitle()    }
    
    // MARK: - TableView setup
    func tableViewSetup() {
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        
        // MARK: - headerView 설정
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300), imageString: "logo")
        tableView.tableHeaderView = headerView
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "category")
        
        // MARK: - AutoLayout 설정
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: guide.topAnchor)
            ])
    }
    
    // MARK: - 데이터 생성하는 부분
    func createPizzaData() {
        
        let superCeed = ["글램핑 바비큐", "알로하 하와이안", "우리 고구마", "콰트로 치즈 퐁듀"]
        let classic = ["베이컨체더치즈", "불고기", "슈퍼디럭스", "슈퍼슈프림", "페퍼로니","포테이토"]
        let priminum = ["더블크러스트 이베리코", "블랙앵거스 스테이크", "블랙타이거 슈림프","와규 앤 비스테카", "직화 스테이크"]
        
        
        
        
        for i in superCeed {
            DataManager.shared.addData(pizzaName: "슈퍼시드", pizzaData: Pizza(PizzaName:i , Count: 0, Price: 10000))
        }
        for i in classic {
            DataManager.shared.addData(pizzaName: "클래식", pizzaData: Pizza(PizzaName: i, Count: 0, Price: 10000))
        }
        for i in priminum {
            DataManager.shared.addData(pizzaName: "프리미엄", pizzaData: Pizza(PizzaName: i, Count: 0, Price: 10000))
        }
    }
}

// Mark: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as! CategoryTableViewCell
        cell.categoryImageView.image = UIImage(named: dataArr[indexPath.row])
        
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productVC = ProductViewController()
        productVC.pizzaTitle = dataArr[indexPath.row]
        show(productVC, sender: nil)
        
    }
}

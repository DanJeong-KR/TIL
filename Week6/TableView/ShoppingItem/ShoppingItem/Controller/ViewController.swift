//
//  ViewController.swift
//  ShoppingItem
//
//  Created by chang sic jung on 25/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var shoppingDataArr: [ShoppingData] = []
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createShoppingData()
        setupTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addButtonTapped(_:)), name: NSNotification.Name(rawValue: "addButtonTapped"), object: nil)
        
    }
    
    func setupTableView() {
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ShoppingTableViewCell", bundle: nil), forCellReuseIdentifier: "Shopping")
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor)])
    }
    
    func createShoppingData() {
        let iphoneList = ["iPhoneSE_Gold","iPhoneSE_RoseGold","iPhoneX_SpaceGray","iPhoneX_White","iPhone1","iPhone2","iPhone3","iPhone4","iPhone5","iPhone6","iPhone7","iPhone8","iPhone9","iPhone10"]
        for i in iphoneList {
            let shoppingdata = ShoppingData(itemImage: UIImage(named: i), itemName: i, itemCount: 0)
            shoppingDataArr.append(shoppingdata)
        }
    }
    
    @objc func addButtonTapped(_ sender: Notification) {
        guard let cell = sender.userInfo?["cell"] as? ShoppingTableViewCell,
              let indexPath = tableView.indexPath(for: cell)
            else { return }
        if shoppingDataArr[indexPath.row].itemCount < shoppingDataArr[indexPath.row].stock {
                shoppingDataArr[indexPath.row].itemCount += 1
                tableView.reloadData()
            }else {
                cell.contentView.backgroundColor = .red
    
                UIView.animate(withDuration: 1, animations: {
                    cell.contentView.backgroundColor = .white
                })
            }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Shopping", for: indexPath) as! ShoppingTableViewCell
        
        cell.itemImageView.image = shoppingDataArr[indexPath.row].itemImage!
        cell.itemNameLabel.text = shoppingDataArr[indexPath.row].itemName ?? ""
        cell.itemCountLabel.text = "\(shoppingDataArr[indexPath.row].itemCount )"
        tableView.rowHeight = 80
        
        //delegate
        //cell.delegate = self
        
        return cell
    }
}

// 델리게이트 메소드!
//extension ViewController: ShoppingTableViewCellDelegate {
//    func sendEvent(_ cell: ShoppingTableViewCell) {
//        guard let indexPath = tableView.indexPath(for: cell) else { return }
//
//        if shoppingDataArr[indexPath.row].itemCount < shoppingDataArr[indexPath.row].stock {
//            shoppingDataArr[indexPath.row].itemCount += 1
//            tableView.reloadData()
//        }else {
//            cell.contentView.backgroundColor = .red
//
//            UIView.animate(withDuration: 1, animations: {
//                cell.contentView.backgroundColor = .white
//            })
//        }
//    }
//}


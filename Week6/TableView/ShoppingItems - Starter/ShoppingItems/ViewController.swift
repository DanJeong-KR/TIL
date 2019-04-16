//
//  ViewController.swift
//  ShoppingItems
//
//  Created by giftbot on 2019. 4. 10..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
    let tableView = UITableView()
    
    var itemList: [String:Int] = ["iPhoneSE_Gold":0,"iPhoneSE_RoseGold":0,"iPhone8plus":0,"iPhoneX_SpaceGray":0,"iPhoneX_White":0,"iPhone1":0,"iPhone2":0,"iPhone3":0,"iPhone4":0,"iPhone5":0,"iPhone6":0,"iPhone7":0,"iPhone8":0,"iPhone9":0,"iPhone10":0]
    
    
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.frame = view.frame
    tableView.dataSource = self
    tableView.register(ItemCell.self, forCellReuseIdentifier: "CellId")
    tableView.rowHeight = 70
    
    view.addSubview(tableView)
    
  }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! ItemCell
    
    //  ItemCell 의 델리게이트 메소드 사용할 것
    cell.delegate = self
    
    let keys = Array(itemList.keys).sorted()

    cell.labelName.text  = keys[indexPath.row]
    cell.labelCount.text = "\(itemList[keys[indexPath.row]]!)"
    cell.imageView?.image = UIImage(named: Array(itemList.keys)[indexPath.row])
    cell.button.setImage(UIImage(named: "add"), for: .normal)
    
    return cell
  }
}


extension ViewController: ItemCellDelegate {
    func itemCellInfo(_ itemCell: ItemCell, didTapCount: Int) {
        guard let indexPath = tableView.indexPath(for: itemCell) else
        { print("ItemCellDelegate 메소드 내부의 indexPath 옵셔널 해제 안된다."); return }
        
        guard let itemCell = tableView.cellForRow(at: indexPath) as? ItemCell else
        { print("ItemCellDelegate 메소드 내부의 cell 옵셔널 해제 문제 "); return }
        
        //itemCell.labelCount.text = "\(didTapCount)"
        
        itemList[itemCell.labelCount.text!] = didTapCount
        
        itemCell.labelCount.text = /*"\(itemList[itemCell.labelCount.text!]!)"*/"\(didTapCount)"
        
    }
}

//
//  ViewController.swift
//  TableViewLecturePractice
//
//  Created by chang sic jung on 15/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var data = Array(1...50)
    
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.frame
        tableView.dataSource = self
        //tableView.delegate = self
        tableView.rowHeight = 60
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        view.addSubview(tableView)
        
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.delegate = self
        
        /*
        let bt = cell.button
        bt.addTarget(self, action: #selector(btAction(sender:)), for: .touchUpInside)
        */
        
        cell.textLabel?.text = "\(data[indexPath.row])"
        return cell
    }
    
    /*
    @objc func btAction(sender: Any) {
        
        
        
        guard let bt = sender as? UIButton else {return}
        //print(bt)
        let selectedCell = bt.superview?.superview as! CustomCell
        
        let indexPath = (selectedCell.superview as! UITableView).indexPath(for: selectedCell)?.row
        
        print("하하",indexPath)
        
        //data[indexPath!] = selectedCell.text
        
        tableView.reloadData()
        
        
    }
 */
    
}

extension ViewController: CustomCellDelegate {
    func customCell(_ customCell: CustomCell, didTapButton: UIButton) {
        
        if let indexPath = tableView.indexPath(for: customCell) {
            let addedNumber = data[indexPath.row] + 1
            data[indexPath.row] = addedNumber
            customCell.textLabel?.text = "\(addedNumber)"
        }
    }
    
    
}


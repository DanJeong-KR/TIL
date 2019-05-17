//
//  MainTableViewController.swift
//  SearchViewControllerExample
//
//  Created by Wi on 11/05/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private var filteredData: [Product] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pizza Search"
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "피자 검색!"
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.scopeButtonTitles = ["All"] + menuData.map {
            $0.category
        }.sorted()
        
        filteredData =  menuData.map{ ($0.menu) }.flatMap{ $0 }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell = reusableCell
        }else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }
        cell.textLabel?.text = filteredData[indexPath.row].name
        cell.detailTextLabel?.text = String(filteredData[indexPath.row].price)
        return cell
    }
    
    // MARK: - For Search method
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        //filteredData = []
        
//        menuData.forEach {
//            let doesCategoryMatch = (scope == "All") || ($0.category == scope)
//
//            if searchBarIsEmpty() {
//                self.filteredData += $0.menu.filter{ _ in doesCategoryMatch }
//            }else {
//                self.filteredData += $0.menu.filter { doesCategoryMatch && $0.name.contains(searchText) }
//            }
//        }
        
        
        if searchBarIsEmpty() {
            filteredData = menuData.filter{
                let doesCategoryMatch = (scope == "All") || ($0.category == scope)
                return doesCategoryMatch
                }.map{ $0.menu }.flatMap { $0 }
        }else {
            filteredData = menuData.filter{
                let doesCategoryMatch = (scope == "All") || ($0.category == scope)
                return doesCategoryMatch
                }.map{ $0.menu.filter { $0.name.contains(searchText) } }.flatMap { $0 }
        }
        
        tableView.reloadData()
    }
    
    private func searchBarIsEmpty() -> Bool {
        // search bar 에 값이 있으면 true
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
}

extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchController.searchBar.text!,scope: scope)
    }
}

extension MainTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        
        print("스코프가 눌렸음")
    }
}



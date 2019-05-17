//
//  MainTableViewController.swift
//  CandiesSearchController
//
//  Created by Wi on 13/05/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

final class MainTableViewController: UITableViewController {
    
    private var candies = [Candy]()
    
    private var filteredCandies = [Candy]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        candies =  [
            Candy(category:"Chocolate", name:"Chocolate Bar"),
            Candy(category:"Chocolate", name:"Chocolate Chip"),
            Candy(category:"Chocolate", name:"Dark Chocolate"),
            Candy(category:"Hard", name:"Lollipop"),
            Candy(category:"Hard", name:"Candy Cane"),
            Candy(category:"Hard", name:"Jaw Breaker"),
            Candy(category:"Other", name:"Caramel"),
            Candy(category:"Other", name:"Sour Chew"),
            Candy(category:"Other", name:"Gummi Bear"),
            Candy(category:"Other", name:"Candy Floss"),
            Candy(category:"Chocolate", name:"Chocolate Coin"),
            Candy(category:"Chocolate", name:"Chocolate Egg"),
            Candy(category:"Other", name:"Jelly Beans"),
            Candy(category:"Other", name:"Liquorice"),
            Candy(category:"Hard", name:"Toffee Apple")]
        
        filteredCandies = candies
        
        // Setup Basic SearchController Setting
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        // Setup other SearchController Setting
        searchController.searchBar.placeholder = "캔디를 검색!"
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Others"]
    
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredCandies.count // * 바뀐 부분
        
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = reusableCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = filteredCandies[indexPath.row].name
        cell.detailTextLabel?.text = filteredCandies[indexPath.row].category
        return cell
        
    }
    
    
    
    // MARK: - For Search method
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filteredCandies = candies.filter {
            let doesCategoryMatch = (scope == "All") || ($0.category == scope)
            if searchBarIsEmpty() {
                return doesCategoryMatch
            }else {
                return doesCategoryMatch && $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        
//
//        if searchBarIsEmpty() {
//            filteredCandies = candies
//        } else {
//
//            filteredCandies = candies.filter {
//                $0.name.contains(searchText)
//            }
//        }
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

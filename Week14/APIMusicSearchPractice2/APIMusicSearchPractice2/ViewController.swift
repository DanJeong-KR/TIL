//
//  ViewController.swift
//  APIMusicSearchPractice2
//
//  Created by chang sic jung on 10/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configures()
        searchBarConfigures()
        apiProcess()
        
        autolayouts()
    }
    
    // MARK: - Configures
    private func configures() {
        
        view.addSubview(tableView)
        tableView.backgroundColor = .yellow
        tableView.dataSource = self
    }
    
    private func searchBarConfigures() {
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search Songs"
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    private func apiProcess() {
        let urlString = "https://itunes.apple.com/search?media=music&entity=song&term=" + "BTS"
        guard let url = URL(string: urlString) else { return print("URL 이 nil 인 error") }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return print(error!.localizedDescription) }
            guard let response = response as? HTTPURLResponse,
            (200..<300) ~= response.statusCode
            //response.mimeType == "application/json"
                else { return print("response 에러 -> 서버에러 ") }
            
            guard let data = data,
            let search = try? JSONDecoder().decode(Search.self, from: data)
                else { return print("data Error") }
            print("search :",search)
        }
        dataTask.resume()

    }
    
    
    // MARK: - AutoLayouts
    private func autolayouts() {
        tableView.layout.top().bottom().leading().trailing()
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}


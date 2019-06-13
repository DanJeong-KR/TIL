//
//  SearchVC.swift
//  URLSessionPractice
//
//  Created by Wi on 10/06/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit
import AVKit

final class SearchVC: UITableViewController {
    // MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var tracks: [Track] = []
    
    private var player: AVPlayer?
    
    var searchWord: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchControllerConfigures()
        
        //getSearchData(searchTerm: "Swift")
        
        // register
        tableView.register(TrackCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CurrentPlayMusicFooterView.self, forHeaderFooterViewReuseIdentifier: "PlayingView")
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 100)
        tableView.separatorColor = .red
            
        
    }
    
    
    private func searchControllerConfigures() {
        self.navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self // 음악 선택하면 검색한 텍스트 없어지는 문제해결하려고
        searchController.searchBar.placeholder = "Search Music"
        searchController.obscuresBackgroundDuringPresentation = true // 흐리게 표현 할 건지
    }
    
    // MARK: - Newworking
    private func getSearchData(searchTerm: String) {
        let defaultSession = URLSession(configuration: .default)
        guard var urlCompoenent = URLComponents(string: "https://itunes.apple.com/search") else { return }
        urlCompoenent.query = "media=music&entity=song&term=\(searchTerm)"
        
        guard let url = urlCompoenent.url else { return }
        let dataTask = defaultSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return print(error!.localizedDescription) }
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else { return }
            
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                self.tracks = result.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }
        dataTask.resume()
    }
    
    
    // MARK: - datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrackCell
        cell.track = self.tracks[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: tracks[indexPath.row].previewUrl) else { return }
        
        guard let footerView = tableView.footerView(forSection: 0) as? CurrentPlayMusicFooterView else { return }
        footerView.track = tracks[indexPath.row]
        footerView.isPlaying = true
//        let avPlayerController = AVPlayerViewController()
        player = AVPlayer(url: url)
//        avPlayerController.player = player
//        present(avPlayerController, animated: true, completion: nil)
        player!.play()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PlayingView") as! CurrentPlayMusicFooterView
        footerView.delegate = self
        
        
        return footerView
    }
}

// MARK: - CurrentPlayMusicFooterViewDelegate
extension SearchVC: CurrentPlayMusicFooterViewDelegate {
    func playPauseButtonDidTap(footerView: CurrentPlayMusicFooterView) {
        guard let player = self.player else { return }
        
        
        if footerView.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        footerView.isPlaying.toggle()
    }
    
    
}

// MARK: - UISearchResultsUpdating
extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        if searchWord != nil {
            getSearchData(searchTerm: searchWord!)
        } else {
            getSearchData(searchTerm: searchBar.text!)
        }
    }
}

extension SearchVC: UISearchControllerDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        searchWord = searchController.searchBar.text // 사라지기 전에 저장을 해놓기
    }
}


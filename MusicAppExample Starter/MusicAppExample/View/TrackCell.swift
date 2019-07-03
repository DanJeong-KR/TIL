//
//  TrackCell.swift
//  URLSessionPractice
//
//  Created by Wi on 10/06/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    
    // MARK: - Properties
    
    var track: Track? {
        didSet {
            guard let track = self.track else { return }
            self.albumImageView.loadImage(with: track.artworkUrl100)
            self.trackNameLabel.text = track.trackName
            self.artistNameLabel.text = track.artistName
        }
    }
    
    let albumImageView: UIImageView = {
        let imgView = UIImageView()
        
        imgView.clipsToBounds = true
        imgView.image = #imageLiteral(resourceName: "defualtMusicImage")
        
        return imgView
    }()
    
    let trackNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Loading.."
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        return lb
    }()
    
    let artistNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Loading.."
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .lightGray
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(albumImageView)
        albumImageView.anchor(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        
        addSubview(trackNameLabel)
        trackNameLabel.anchor(top: nil, left: albumImageView.trailingAnchor, bottom: nil, right: trailingAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        trackNameLabel.centerYAnchor.constraint(equalTo: albumImageView.centerYAnchor, constant:  -5).isActive = true
        
        addSubview(artistNameLabel)
        artistNameLabel.anchor(top: trackNameLabel.bottomAnchor, left: albumImageView.trailingAnchor, bottom: nil, right: trailingAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

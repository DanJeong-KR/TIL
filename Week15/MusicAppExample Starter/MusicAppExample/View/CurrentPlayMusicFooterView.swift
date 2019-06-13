//
//  CurrentPlayMusicFooterView.swift
//  URLSessionPractice
//
//  Created by Wi on 11/06/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit
// footer View 만들 것
class CurrentPlayMusicFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    // MARK: - data properties
    
    var isPlaying = false {
        didSet {
            self.isPlayingLabel.isHidden = isPlaying
            self.trackNameLabel.isHidden = !isPlaying
            self.artistNameLabel.isHidden = !self.isPlaying
            self.playButton.isSelected = self.isPlaying
        }
    }
    
    var track: Track? {
        didSet {
            guard let track = self.track else { return }
            self.albumImageView.loadImage(with: track.artworkUrl100)
            self.trackNameLabel.text = track.trackName
            self.artistNameLabel.text = track.artistName
        }
    }
    
    var delegate: CurrentPlayMusicFooterViewDelegate?
    
    // MARK: - UI ProPerties
    
    let albumImageView: UIImageView = {
        let imgView = UIImageView()
        
        imgView.clipsToBounds = true
        imgView.image = #imageLiteral(resourceName: "defualtMusicImage")
        imgView.layer.cornerRadius = 2
        imgView.clipsToBounds = true
        
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
    
    let isPlayingLabel: UILabel = {
        let lb = UILabel()
        
        lb.text = "재생 중이 아님"
        lb.font = UIFont.systemFont(ofSize: 18, weight: .ultraLight)
        
        return lb
    }()
    
    let playButton: UIButton = {
        let bt = UIButton(type: .custom)
        
        bt.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        bt.setImage(#imageLiteral(resourceName: "pause"), for: .selected)
        bt.imageView?.contentMode = .scaleAspectFit
        bt.addTarget(self, action: #selector(playButtonDidTapped(_:)), for: .touchUpInside)
        return bt
    }()
    
    let nextButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setImage(#imageLiteral(resourceName: "next"), for: .normal)
        bt.imageView?.contentMode = .scaleAspectFit
        bt.tintColor = UIColor.lightGray
        bt.addTarget(self, action: #selector(playButtonDidTapped(_:)), for: .touchUpInside)
        return bt
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(albumImageView)
        albumImageView.anchor(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 10 , paddingRight: 0, width: 50, height: 50)
        
        addSubview(isPlayingLabel)
        isPlayingLabel.anchor(top: nil, left: albumImageView.trailingAnchor, bottom: nil, right: trailingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        isPlayingLabel.centerYAnchor.constraint(equalTo: albumImageView.centerYAnchor).isActive = true
        
        
        addSubview(nextButton)
        nextButton.anchor(top: nil, left: nil, bottom: nil, right: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 30, height: 25)
        nextButton.centerYAnchor.constraint(equalTo: albumImageView.centerYAnchor).isActive = true
        
        
        addSubview(playButton)
        playButton.anchor(top: nil, left: nil, bottom: nil, right: nextButton.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 45, width: 30, height: 35)
        playButton.centerYAnchor.constraint(equalTo: albumImageView.centerYAnchor).isActive = true
        
        
        addSubview(trackNameLabel)
        trackNameLabel.anchor(top: nil, left: albumImageView.trailingAnchor, bottom: nil, right: playButton.leadingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        trackNameLabel.centerYAnchor.constraint(equalTo: albumImageView.centerYAnchor,constant: -10).isActive = true
        trackNameLabel.isHidden = true
        
        addSubview(artistNameLabel)
        artistNameLabel.anchor(top: trackNameLabel.bottomAnchor, left: albumImageView.trailingAnchor, bottom: nil, right: trailingAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        artistNameLabel.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    @objc private func playButtonDidTapped(_ sender: UIButton) {
        print("playButtonDidTapped")
        sender.zoomIn()
        delegate?.playPauseButtonDidTap(footerView: self)
    }
    
}

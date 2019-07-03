//
//  AddFeedTableViewCell.swift
//  Instagram
//
//  Created by Wi on 30/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class AddFeedTableViewCell: UITableViewCell {
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.delegate = self
        textView.text = "문구입력..."
        textView.textColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AddFeedTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "문구입력..." && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "문구입력..."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}

//
//  AddFeedTableViewCell.swift
//  Instagram
//
//  Created by Wi on 30/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

// AddFeedVC에서 하나만 사용될 셀입니다.
// 이 부분은 배우지 않았으니 이 파일을 그대로 사용한다면 추가적으로 구현할 사항은 없습니다.
// xib 파일에서 셀이 어떤식으로 생겼는지 확인해보세요.
// xib 방식은 선택사항입니다. 코드로 해보고 싶은 분들은 새롭게 코드로 구현해보세요.

class AddFeedTableViewCell: UITableViewCell {
    
    // 사진을 선택하면 이곳에 이미지를 나타내 주어야합니다.
    @IBOutlet weak var feedImageView: UIImageView!
    // 사진밑에 설명을 입력하는 텍스트 뷰 입니다. (텍스트필드가 아닙니다.)
    @IBOutlet weak var
    textView: UITextView!
    
    
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
// 텍스트 뷰를 텍스트 필드처럼 사용하기 위헤 placeholder를 만드는 방법입니다.
// 프로젝트때 필요하시면 사용해보세요.

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

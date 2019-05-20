//
//  CommentTableViewCell.swift
//  Instagram
//
//  Created by Wi on 23/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

// 댓글이 보여질 셀입니다.
// CommentVC에서 이 셀을 사용해 댓글을 표현해주세요.
// xib 파일에서 셀이 어떤식으로 생겼는지 확인해보세요.
// xib 방식은 선택사항입니다. 코드로 해보고 싶은 분들은 새롭게 코드로 구현해보세요.
class CommentTableViewCell: UITableViewCell {
    
    // 이미지 뷰에 이미지 띄우는 것은 선택사항입니다.
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedNickNameLabel: UILabel!
    @IBOutlet weak var feedComment: UILabel!
    
    // 이미지 뷰에 이미지를 띄웠다면 동그랗게 만들어보세요.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

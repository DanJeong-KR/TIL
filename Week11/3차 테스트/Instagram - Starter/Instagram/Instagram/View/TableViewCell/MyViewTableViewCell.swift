//
//  MyViewTableViewCell.swift
//  Instagram
//
//  Created by Wi on 03/05/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit
// 프로필 이미지를 고치고 닉네임을 변경할 이벤트를 전달 하는 셀입니다.
// xib 파일에서 셀이 어떤식으로 생겼는지 확인해보세요.
// xib 방식은 선택사항입니다. 코드로 해보고 싶은 분들은 새롭게 코드로 구현해보세요.
class MyViewTableViewCell: UITableViewCell {
    @IBOutlet weak var myProfileImageView: UIImageView!
    @IBOutlet weak var changeProfileBtn: UIButton!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    // 데이터가 들어올 자리입니다.
    // 이 구현 방식은 선택사항입니다. 다르게 구현해도 괜찮습니다.
    var model: User?{
        didSet{
        }
    }
    
    // 이미지뷰에 제스처를 붙여서 클릭하면 이벤트가 발생되도록 구현해보세요.
    // 이미지뷰를 동그랗게 만들어보세요.
    // 닉네임 수정버튼에 볼더(테두리)를 추가해보세요
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // 닉네임 수정 버튼을 눌렀을때 호출될 함수 입니다.
    // 힌트: AddFeedVC에게 닉네임 수정 버튼이 눌렸다는 것을 알려주세요.
    @IBAction func changeProfileBtnDidTap(_ sender: Any) {

    }
    
    // 추가적으로 제스처 이벤트가 발생했을때 구현될 함수를 하나더 만들어주세요.
    // 힌트: AddFeedVC에게 프로필 이미지뷰의 제스처 이벤트가 발생했다는 것을 알려주세요.
    
    
    
}

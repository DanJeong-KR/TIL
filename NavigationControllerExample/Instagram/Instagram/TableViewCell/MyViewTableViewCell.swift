//
//  MyViewTableViewCell.swift
//  Instagram
//
//  Created by Wi on 03/05/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class MyViewTableViewCell: UITableViewCell {
    @IBOutlet weak var myProfileImageView: UIImageView!
    @IBOutlet weak var changeProfileBtn: UIButton!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    var model: User?{
        didSet{
            myProfileImageView.image = self.model?.profileImage ?? UIImage(named: "profile3")
            nickNameTextField.text = self.model?.userName ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchProfileImageView)))
        myProfileImageView.isUserInteractionEnabled = true
        
        myProfileImageView.layer.cornerRadius = myProfileImageView.frame.width / 2
        changeProfileBtn.layer.borderWidth = 0.5
        changeProfileBtn.layer.borderColor = UIColor.lightGray.cgColor
        changeProfileBtn.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeProfileBtnDidTap(_ sender: Any) {
        nickNameTextField.resignFirstResponder()
        NotificationCenter.default.post(name: NSNotification.Name("nickNameChange"), object: nil, userInfo: ["nickName": nickNameTextField.text ?? ""] )
    }
    @objc private func touchProfileImageView(_ sender: Any) {
        nickNameTextField.resignFirstResponder()
        NotificationCenter.default.post(name: NSNotification.Name("profileImageView"), object: nil)
    }
}

//
//  TableViewCell.swift
//  BasicTableView
//
//  Created by 이봉원 on 11/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
  
  // 스토리보드일 때는 awakeFromNib()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // 코드로 생성 시
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    print("\n---------- [ init(style:reuserIdentifier) ] ----------")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    print("\n---------- [ prepareForReuse ] ----------")
  }
  
  deinit {
    print("Deinit")
  }
}

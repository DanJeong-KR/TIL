
/*
 1. 각 아이템은 한정된 재고 수량을 가짐
 2. 버튼을 통해 해당 아이템의 주문 수량을 늘리려고 하면
        - 재고 수량을 초과하면 셀 배경색을 일시적으로 빨갛게
        - 추가로 주문 불가 메세지 출력 (print or alert)
 
 */
import UIKit

// 내가 사용할 함수를 정의하는 프로토콜 정의하고
protocol ItemCellDelegate: class {
    func itemCellInfo(_ itemCell: ItemCell, didTapCount: Int)
}

final class ItemCell: UITableViewCell {
    
    weak var delegate: ItemCellDelegate?
    
    var itemList: [String] = ["iPhoneSE_Gold","iPhoneSE_RoseGold","iPhone8plus","iPhoneX_SpaceGray","iPhoneX_White","iPhone1","iPhone2","iPhone3","iPhone4","iPhone5","iPhone6","iPhone7","iPhone8","iPhone9","iPhone10"]
    
    var tapCount = 0
    
    let button = UIButton()
    let labelName = UILabel()
    let labelCount = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(button)
        contentView.addSubview(labelName)
        contentView.addSubview(labelCount)
        
        button.addTarget(self, action: #selector(didTapAction(_:)), for: .touchUpInside)
        labelCount.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 코드로 오토레이아웃 잡을때 오토리사이징 마스크 충돌에러 방지.
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelCount.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // LabelName AutoLayout
        labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        labelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 130).isActive = true
        labelName.widthAnchor.constraint(equalToConstant: 170).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // LabelCount AutoLayout
        labelCount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        labelCount.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 10).isActive = true
        labelCount.widthAnchor.constraint(equalToConstant: 40).isActive = true
        labelCount.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Button AutoLayout
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    }
    
    @objc func didTapAction(_ sender: UIButton) {
        // 각 상품별로 한정 수량 지정하기
        switch labelName.text {
        case itemList[0]:
            iterate(3)
        case itemList[1]:
            iterate(4)
        case itemList[2]:
            iterate(5)
        case itemList[3]:
            iterate(4)
        case itemList[4]:
            iterate(3)
        case itemList[5]:
            iterate(2)
        case itemList[6]:
            iterate(4)
        case itemList[7]:
            iterate(3)
        case itemList[8]:
            iterate(4)
        case itemList[9]:
            iterate(3)
        case itemList[10]:
            iterate(2)
        case itemList[11]:
            iterate(4)
        case itemList[12]:
            iterate(3)
        case itemList[13]:
            iterate(2)
        case itemList[14]:
            iterate(1)
            
        default:
            break
        }
        
        delegate?.itemCellInfo(self, didTapCount: tapCount)
    }
    
    // 재고에 따라 있으면 주문수량 늘리고 , 그게 아니면 못올라가게 하는 로직
    func iterate(_ limitCount: Int){
        if tapCount < limitCount {
            tapCount += 1
        }else{
            // 애니메이션
            print("재고부족")
            self.backgroundColor = .red
            UIView.animate(withDuration: 2) {
                self.backgroundColor = .white
            }
        }
        
    }
    
}

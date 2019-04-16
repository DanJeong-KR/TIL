import UIKit

protocol ItemCellDelegate: class {
    func didTapButton(ItemCell: ItemCell)
}


// 보여주기
class ItemCell: UITableViewCell {
    
    weak var delegate: ItemCellDelegate?
    
    
    let nameLabel = UILabel()
    let countLabel = UILabel()
    let addButton = UIButton()
    let imgView = UIImageView()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpContentView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("ItemCell 초기화 부분")
    }
    
    // MARK: - 커스텀 셀 contentView 초기 설정값
    func setUpContentView() {
        contentView.addSubview(imgView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(addButton)
        
        
        //UITest
//        nameLabel.backgroundColor = .yellow
//        countLabel.backgroundColor = .red
//        addButton.backgroundColor = .black
        
        //
        countLabel.textAlignment = .center
        addButton.setImage(UIImage(named: "add"), for: .normal)
        addButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
    }
    
    @objc func buttonAction(sender: UIButton) {
        
        // 셀에 대한 정보 넘겨서 여기서 버튼 클릭하면 해당 이벤트 처리를 VC 에 하자.
        // View 는 보여주기만 하는 아이라구!
        delegate?.didTapButton(ItemCell: self)
        
    }
    
    // MARK: - content view 오토레이아웃
    override func layoutSubviews() {
        // 코드로 오토레이아웃 잡을때 오토리사이징 마스크 충돌에러 방지.
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        // ImageView AutoLayout
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // LabelName AutoLayout
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 130).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // LabelCount AutoLayout
        countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Button AutoLayout
        addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}

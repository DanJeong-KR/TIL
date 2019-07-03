
import UIKit

protocol FeedTableViewCellDelegate: class {
    func sendButtonInfo(cell:FeedTableViewCell)
}

class FeedTableViewCell: UITableViewCell {
    
    weak var delegate: FeedTableViewCellDelegate?

    @IBOutlet weak var pfImageView: UIImageView!
    @IBOutlet weak var pfNameLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var commentButton: UIButton!
    
    var model: FeedData! {
        didSet { // 값이 들어오면 뷰에 보여주는 역할
            pfImageView.image = UIImage(named: self.model.profileImage!)
            pfNameLabel.text = self.model.nickName
            feedImageView.image = UIImage(named: self.model.feedImage!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pfImageView.layer.cornerRadius = pfImageView.frame.width / 2
        
        pfImageView.image = UIImage(named: AppImageData.profile + "\(1)")
        //feedImageView.image = UIImage(named: AppImageData.feedImage + "\(1)")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        
        sender.isSelected.toggle()
    }
    
    
    
    // MARK: - 델리게이트
    @IBAction func commentButtonAction(_ sender: UIButton) {
        
        delegate?.sendButtonInfo(cell: self)
    }
    
    
}



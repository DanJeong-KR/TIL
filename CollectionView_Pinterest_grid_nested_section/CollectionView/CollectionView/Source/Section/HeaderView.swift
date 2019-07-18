import UIKit

final class HeaderView: UICollectionReusableView {
  
  // MARK: - Property
  
  // UI
  var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: - Initializer
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white 
    configureLabel()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.backgroundColor = .white
    configureLabel()
  }

  // MARK: - Configure
  
  private func configureLabel() {
    self.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
    ])
  }
}

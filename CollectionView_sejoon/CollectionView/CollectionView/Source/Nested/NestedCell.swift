import UIKit

final class NestedCell: UITableViewCell {
  
  // MARK: - CollectionViewMetric
  
  private enum Metric {
    static let lineSpacing: CGFloat = 3
    static let itemSpacing: CGFloat = 3
    static let nextOffSet: CGFloat = 0
    
    static let numberOfLine: CGFloat = 2
    static let numberOfItem: CGFloat = 2
    
    static let inset: UIEdgeInsets = .init(top: 3, left: 3, bottom: 3, right: 3)
    
    static var horizontalPadding: CGFloat {
      return Metric.inset.left + Metric.inset.right
    }
    
    static var verticalPadding: CGFloat {
      return Metric.inset.top + Metric.inset.bottom
    }
  }
  
  // MARK: - Property
  // Source
  var cards: [Card] = []
  
  // UI
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    return collectionView
  }()
  
  var offset: CGFloat {
    get {
      return collectionView.contentOffset.x
    }
    set {
      collectionView.contentOffset.x = newValue
    }
  }
  
  // MARK: - Intilizer
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureColllectionView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureColllectionView()
  }
  
  // MARK: - Configure
  
  private func configureColllectionView() {
    contentView.backgroundColor = .white
    contentView.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
    ])
  }
  
}

// MARK: - UICollectionViewDataSource

extension NestedCell: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return cards.count }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.contentView.layer.cornerRadius = 5.0
    cell.contentView.backgroundColor = cards[indexPath.item].color
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout\

extension NestedCell: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
    let horizontalPadding = Metric.inset.left + Metric.inset.right + Metric.nextOffSet
    
    let itemSpacing = Metric.itemSpacing * (Metric.numberOfItem - 1)
    let verticalPadding = Metric.inset.top + Metric.inset.bottom
    
    let width = (collectionView.frame.width - lineSpacing - horizontalPadding) / Metric.numberOfLine
    let height = (collectionView.frame.height - itemSpacing - verticalPadding) / Metric.numberOfItem
    
    return CGSize(width: width.rounded(.down), height: height.rounded(.down))
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Metric.lineSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Metric.itemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return Metric.inset
  }
}

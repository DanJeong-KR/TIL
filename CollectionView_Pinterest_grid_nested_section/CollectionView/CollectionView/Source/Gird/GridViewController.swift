import UIKit

final class GridViewController: UIViewController {
  
  // MARK: - CollectionViewMetric
  
  private enum Metric {
    static let lineSpacing: CGFloat = 20
    static let itemSpacing: CGFloat = 3
    static let nextOffSet: CGFloat = 5 // 다음 컬렉션 살짝 보이게 만드는 OffSet
    
    static let numberOfLine: CGFloat = 2
    static let numberOfItem: CGFloat = 2
    
    static let inset: UIEdgeInsets = .init(top: 6, left: 6, bottom: 6, right: 6)
    
    static var horizontalPadding: CGFloat {
      return Metric.inset.left + Metric.inset.right
    }
    
    static var verticalPadding: CGFloat {
      return Metric.inset.top + Metric.inset.bottom
    }
  }
  
  // MARK: - Property
  
  private var source: [Card] = cards
  
  lazy private var collectionView: UICollectionView = {
    // layout
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    // view
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    
    return collectionView
  }()
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    configureCollectionView()
  }
  
  private func configureCollectionView() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 300),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
    
  }
  
}

// MARK: - UICollectionViewDataSource

extension GridViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return source.count }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//    cell.contentView.layer.cornerRadius = 5.0
    cell.contentView.backgroundColor = source[indexPath.item].color
    return cell
  }
}

// MARK: - UICollectionViewFlowLayout

extension GridViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    /// 딱 떨어지게 만들기 위한 식들.
    let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
    let horizontalPadding = Metric.inset.left + Metric.inset.right + Metric.nextOffSet
    
    let itemSpacing = Metric.itemSpacing * (Metric.numberOfItem - 1)
    let verticalPadding = Metric.inset.top + Metric.inset.bottom
    
    let width = (collectionView.frame.width - lineSpacing - horizontalPadding) / Metric.numberOfLine
    let height = (collectionView.frame.height - itemSpacing - verticalPadding) / Metric.numberOfItem
    
    return CGSize(width: width.rounded(.down), height: height.rounded(.down)) // 소수점 떄문에 정확히 안떨어지니까 소수점 버리기
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

import UIKit

final class SectionViewController: UIViewController {

  // MARK: - CollectionViewMetric
  
  private enum Metric {
    static let lineSpacing: CGFloat = 3
    static let itemSpacing: CGFloat = 3
    static let nextOffSet: CGFloat = 0
    
    static let numberOfLine: CGFloat = 3
    static let numberOfItem: CGFloat = 3
    
    static let inset: UIEdgeInsets = .init(top: 3, left: 3, bottom: 3, right: 3)
    
    static var horizontalPadding: CGFloat {
      return Metric.inset.left + Metric.inset.right
    }
    
    static var verticalPadding: CGFloat {
      return Metric.inset.top + Metric.inset.bottom
    }
  }
  
  // MARK: - Property
  
  var source: [Section] = sections
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionHeadersPinToVisibleBounds = true
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .white
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
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
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(moveGesture))
    collectionView.addGestureRecognizer(longPressGesture)
  }
  
}


extension SectionViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int { return source.count }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return source[section].cards.count }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.contentView.layer.cornerRadius = 5.0
    cell.contentView.backgroundColor = source[indexPath.section].cards[indexPath.item].color
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderView
      header.titleLabel.text = "\(indexPath.section)"
      return header
    case UICollectionView.elementKindSectionFooter:
      fatalError()
    default:
      fatalError()
    }
  }
  
  // 이동된 Cell 에 대해서 Model 도 변경시켜야 한다. 모델이랑 동기화 시키기
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    guard sourceIndexPath != destinationIndexPath else { return }
    let newElement = source[sourceIndexPath.section].cards.remove(at: sourceIndexPath.item)
    source[destinationIndexPath.section].cards.insert(newElement, at: destinationIndexPath.item)
    
  }
  
}

extension SectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 80)
  }
  
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


extension SectionViewController {
  
  // UILongPressGestureRecognizer 으로 꾸욱 클릭한 곳을 알아낼 거에요.
  @objc func moveGesture(_ sender: UILongPressGestureRecognizer) {
    let location = sender.location(in: collectionView)
    switch sender.state {
    case .began:
      let itemIndexPath = collectionView.indexPathForItem(at: location)!
      collectionView.beginInteractiveMovementForItem(at: itemIndexPath)
    case .changed:
      // 해당 Cell 이 움직이고 있다고 계속 알려줘야 한다.
      // 알려주면 FlowLayout 이 내부적으로 처리해준더.
      collectionView.updateInteractiveMovementTargetPosition(location)
    case .cancelled:
      collectionView.cancelInteractiveMovement()
    case .ended:
      collectionView.endInteractiveMovement()
    default:
      break
    }
  }
}

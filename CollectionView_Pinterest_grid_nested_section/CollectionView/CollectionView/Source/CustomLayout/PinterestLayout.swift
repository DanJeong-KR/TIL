import UIKit

// MARK: - Delegate

protocol PinterestLayoutDelegate: UICollectionViewDelegate {
  
  /// 높이를 내가 넣을 컨텐츠에 따라 바뀌어야 하는지에 대한 Delegate
  func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat
}

// MARK: - PinteresLayout

final class PinterestLayout: UICollectionViewLayout {
  
  var metric: PinterestLayoutMetric = .default
  weak var delegate: PinterestLayoutDelegate?
  
  // MARK: - Private Property
  private var cache: [UICollectionViewLayoutAttributes] = []
  private var totalHeight: CGFloat = 0
  
  private var contentWidth: CGFloat {
    guard let collectionView = collectionView else { return 0 }
    return collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
  }
  
  
  override var collectionViewContentSize: CGSize {
    guard let collectionView = collectionView else { return .zero }
    let inset = collectionView.contentInset
    return CGSize(width: collectionView.bounds.width, height: totalHeight + inset.top + inset.bottom)
  }
  
  override func prepare() {
    guard let collectionView = collectionView else { return }
    
    var xOffSet: [CGFloat] = []
    var yOffSet = [CGFloat](repeating: 0, count: metric.numberOfColumn)
    
    let padding: CGFloat = (metric.cellPadding * CGFloat(metric.numberOfColumn - 1))
    let cellWidth: CGFloat = (contentWidth - padding) / CGFloat(metric.numberOfColumn)
    
    for column in 0..<metric.numberOfColumn {
      xOffSet.append(CGFloat(column) * (cellWidth + metric.cellPadding))
    }
    
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      let column = item % metric.numberOfColumn
      
      let indexPath = IndexPath(item: item, section: 0)
      let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      let itemHeight = delegate?.collectionView(collectionView, heightForItemAt: indexPath) ?? metric.itemHeight
      attribute.frame = CGRect(x: xOffSet[column], y: yOffSet[column], width: cellWidth, height: itemHeight)
      cache.append(attribute)
      
      yOffSet[column] += itemHeight + metric.cellPadding
      if yOffSet[column] > totalHeight {
        totalHeight = yOffSet[column]
      }
    }
    
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let result = cache.filter { $0.frame.intersects(rect) }
    return result
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache.first { $0.indexPath == indexPath }
  }
  
  // MARK: - Invalidate
  
  override func invalidateLayout() {
    cache.removeAll()
    totalHeight = 0
    super.invalidateLayout()
  }
  
}


// MARK: - Metric

struct PinterestLayoutMetric {
  let contentInset: UIEdgeInsets
  let cellPadding: CGFloat
  let itemHeight: CGFloat
  let numberOfColumn: Int
  
  static let `default` = PinterestLayoutMetric(contentInset: .zero, cellPadding: 5, itemHeight: 100, numberOfColumn: 3)
}


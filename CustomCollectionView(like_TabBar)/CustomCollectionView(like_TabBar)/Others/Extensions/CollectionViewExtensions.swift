
import UIKit

extension UITableViewCell: Identifiable { }
extension UICollectionViewCell: Identifiable { }

extension UICollectionView {
    func register<Cell> (
        cell: Cell.Type,
        forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
        ) where Cell: UICollectionViewCell {
        register(cell, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeue<Cell>(
        _ reusableCell: Cell.Type,
        _ indexpath: IndexPath) -> Cell where Cell: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: reusableCell.identifier, for: indexpath) as? Cell else { fatalError("Could not find cell with identifier") }
        return cell
    }
    // header, footer register 하는 forSupplementaryViewOfKind 메소드 도 extension 으로 좀 더 고민해보자.
}

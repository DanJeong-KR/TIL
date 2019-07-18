import UIKit

final class NestedCollectionViewController: UIViewController {
  
  // MARK: - Property
  // Source
  var source: [Section] = sections
  
  // UI
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(NestedCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()
  
  private var cachedOffset: [Int: CGFloat] = [:]
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureTableView()
  }
  
  // MARK: - Configure
  private func configureTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
  }
}

// MARK: - UITableViewDataSource

extension NestedCollectionViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int { return 1 }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return source.count }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NestedCell
    cell.cards = source[indexPath.item].cards
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
}

// MARK: - UITableViewDelegate
/// 셀이 재사용 됨으로 생기는 버그를 고치기 위해.
/// TableView 의 첫 row 를 끝까지 스크롤하고  스크롤 내리면
/// 재사용 메커니즘 떄문에 재사용 된 셀에서는 마찬가지로 끝까지 스크롤 되어있는 버그
extension NestedCollectionViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? NestedCell else { return }
    cell.offset = cachedOffset[indexPath.row] ?? 0
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? NestedCell else { return }
    cachedOffset[indexPath.row] = cell.offset
  }
}

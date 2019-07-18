import UIKit


final class MainViewController: UIViewController {
  
  // MARK: - Property
  @IBOutlet weak var tableView: UITableView!
  var source: [(name: String, type: UIViewController.Type)] = [
    (name: "Grid", type: GridViewController.self),
    (name: "Section", type: SectionViewController.self),
    (name: "Nested", type: NestedCollectionViewController.self),
    (name: "CustomLayout", type: CustomLayoutViewController.self),
  ]
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}


// MARK: - TableViewDataSource

extension MainViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int { return 1 }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return source.count }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = source[indexPath.row].name
    return cell
  }
  
}


// MARK: - TableViewDelegate

extension MainViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let viewControllerType = source[indexPath.row].type
    let nextViewController = viewControllerType.init()
    self.navigationController?.pushViewController(nextViewController, animated: true)
  }
}

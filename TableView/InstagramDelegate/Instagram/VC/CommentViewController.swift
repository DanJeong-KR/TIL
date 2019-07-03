
import UIKit

class CommentViewController: UIViewController {
    
    var feedData: FeedData?
    
    let testLabel = UILabel()
    
    let contentView: ContentView = {
        let contentView = ContentView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(contentView)
        autoLayout()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "Comment")
        
        contentView.delegate = self
        
    }
    
    
    func autoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        // tableView 레이아웃
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.topAnchor)])
        
        // contentView 레이아웃
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 140),
            //contentView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)])
    }
}



extension CommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (feedData?.comment.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Comment", for: indexPath) as! CommentTableViewCell
        cell.feedImageView?.image = UIImage(named: feedData?.feedImage ?? "")
        cell.feedNameLabel.text = feedData?.nickName ?? "nil"
        cell.feedCommentLabel.text = feedData?.comment[indexPath.row] ?? "nil"
        
        tableView.rowHeight = cell.frame.height
        
        return cell
        
    }

}


// MARK: - ContentViewDelegate
extension CommentViewController: ContentViewDelegate {
    func rightViewButtinDidTapped(text: String) {
        feedData?.comment.append(text)
        FeedManager.shared.addFeedData(feedData!)
        tableView.reloadData()
    }
    
    
}

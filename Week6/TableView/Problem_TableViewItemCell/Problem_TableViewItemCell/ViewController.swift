

import UIKit



class ViewController: UIViewController {
    
    let tableView = UITableView()
    let ItemList = ["iPhoneSE_Gold","iPhoneSE_RoseGold","iPhone8","iPhoneX_SpaceGray","iPhoneX_White","iPhone1","iPhone2","iPhone3","iPhone4","iPhone5","iPhone6","iPhone7","iPhone11","iPhone9","iPhone10"]
    var dataList: [CellDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        // 데이터 모델의 인스턴스 생성. 셀이 표현할 개수만큼
        for i in ItemList {
            let dataInstance = CellDataModel(name: i, count: 0, image: UIImage(named: i)!)
            dataList.append(dataInstance)
        }
        
        // 재고수량 설정하기 귀찮아서 loop 돌릴게
        for i in dataList{
            i.stocks = 3
        }
        dataList[0].stocks = 2
        dataList[1].stocks = 1
    }
    
    // MARK: - tableView 초기설정
    func setUpTableView() {
        view.addSubview(tableView)
        
        // 테이블 뷰 오토레이아웃 잡기
        setUpTableViewAutoLayout()
        
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(ItemCell.self, forCellReuseIdentifier: "CellId")
    }
    
    // 테이블뷰 오토레이아웃
    func setUpTableViewAutoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! ItemCell
        cell.delegate = self
        cell.nameLabel.text = dataList[indexPath.row].name
        cell.countLabel.text = "\(dataList[indexPath.row].count!)"
        cell.imgView.image = dataList[indexPath.row].image ?? UIImage(named: "add")
        
        return cell
    }
    
    
}

// MARK: - ItemCellDelegate
extension ViewController: ItemCellDelegate {
    
    func didTapButton(ItemCell: ItemCell) {
        
        guard let indexPath = tableView.indexPath(for: ItemCell)
            else{ print("델리게이트 메소드 nil"); return }
        
        if dataList[indexPath.row].count! >= dataList[indexPath.row].stocks {
            ItemCell.backgroundColor = .red
            UIView.animate(withDuration: 1) { ItemCell.backgroundColor = .white }
        }else {
            dataList[indexPath.row].count! += 1
        }
        
        
        ItemCell.countLabel.text = "\(dataList[indexPath.row].count!)"
        
    }

}

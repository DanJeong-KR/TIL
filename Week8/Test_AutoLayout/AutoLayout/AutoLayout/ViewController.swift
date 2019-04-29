
/*
 
 subView 크기는 super 의 절반, 정가운데 위치
 라벨 폰트 23, 배경색 흰색
 
 */

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var orangeView: UIView!
    
    let skyBlueView = UIView()
    let navyBlueView = UIView()
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupLayout()
    }
    
    func setupView() {
        view.addSubview(skyBlueView)
        skyBlueView.addSubview(navyBlueView)
        skyBlueView.addSubview(label)
        
        skyBlueView.backgroundColor = UIColor(displayP3Red: 0, green: 0.7, blue: 0.8, alpha: 1)
        navyBlueView.backgroundColor = .blue
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 23)
        label.text = "네번째 문제"
        label.textAlignment = .center
        
    }
    
    func setupLayout() {
        skyBlueView.translatesAutoresizingMaskIntoConstraints = false
        navyBlueView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //sky
            skyBlueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skyBlueView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            skyBlueView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.5),
            skyBlueView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.5),
            // navy
            navyBlueView.centerXAnchor.constraint(equalTo: skyBlueView.centerXAnchor),
            navyBlueView.centerYAnchor.constraint(equalTo: skyBlueView.centerYAnchor),
            navyBlueView.widthAnchor.constraint(equalTo: skyBlueView.widthAnchor, multiplier: 0.5),
            navyBlueView.heightAnchor.constraint(equalTo: skyBlueView.heightAnchor, multiplier: 0.5),
            // label
            label.centerXAnchor.constraint(equalTo: navyBlueView.centerXAnchor,constant: 20),
            label.centerYAnchor.constraint(equalTo: navyBlueView.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 28),
            label.widthAnchor.constraint(greaterThanOrEqualTo: navyBlueView.widthAnchor, multiplier: 0.7)
            ])
        
    }


}


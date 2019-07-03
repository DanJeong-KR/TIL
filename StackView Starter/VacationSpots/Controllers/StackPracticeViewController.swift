

import UIKit

class StackPracticeViewController: UIViewController {
    
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    lazy var labels = [label1,label2,label3]
    
    let button1 = UIButton(type: .system)
    let button2 = UIButton(type: .system)
    let button3 = UIButton(type: .system)
    lazy var buttons = [button1, button2, button3]
    
    let labelStackView = UIStackView()
    let buttonStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        autolayouts()
    }
    
    private func configure() {
        
        viewsConfigure()
        stackViewConfigure()
        view.addSubviews([labelStackView,buttonStackView])
        labels.forEach { labelStackView.addArrangedSubview($0) }
        buttons.forEach { buttonStackView.addArrangedSubview($0) }
        
    }
    
    private func viewsConfigure() {
        labels.forEach {
            $0.text = "test"
            $0.font = UIFont.boldSystemFont(ofSize: 30)
            //$0.backgroundColor = .yellow
        }
        
        buttons.forEach {
            $0.setTitle("btn", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            $0.backgroundColor = .green
        }
        
    }
    
    private func stackViewConfigure() {
        labelStackView.axis = .horizontal
        labelStackView.backgroundColor = .lightGray
        labelStackView.layer.borderColor = UIColor.black.cgColor
        labelStackView.layer.borderWidth = 10
        labelStackView.spacing = 30
        labelStackView.alignment = .leading
        labelStackView.distribution = .fillEqually
        
        buttonStackView.backgroundColor = .black
    }
    
    private func autolayouts() {
        labelStackView.layout.centerX().centerY(constant: -150)
        labelStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        labelStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        buttonStackView.layout.centerX().centerY(constant: 150)
    }

}

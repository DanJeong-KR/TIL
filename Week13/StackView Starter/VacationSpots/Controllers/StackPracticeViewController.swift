

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
    
    private func 
    
    private func configure() {
        view.addSubviews([labelStackView,buttonStackView])
        labels.forEach { labelStackView.addArrangedSubview($0) }
        buttons.forEach { buttonStackView.addArrangedSubview($0) }
    }
    
    private func autolayouts() {
        labelStackView.layout.centerX().centerY(constant: -150)
    }

}

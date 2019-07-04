

import UIKit

class QuizViewController: UIViewController {
  /// Curent game state
  var state = State(questions: questions)
  
  /// Current question countdown timer
  var timer: Timer?
  
  /// Progress bar constraint
  var progressConstraint: NSLayoutConstraint!

  // MARK: - Views
  lazy var viewProgress: UIView = {
    let v = UIView(frame: .zero)
    v.backgroundColor = .green
    view.addSubview(v)
    
    return v
  }()
  
  lazy var lblTimer: UILabel = {
    let lbl = UILabel(frame: .zero)
    lbl.layer.cornerRadius = 8
    lbl.layer.borderColor = UIColor.black.cgColor
    lbl.layer.borderWidth = 2
    lbl.textAlignment = .center
    lbl.font = UIFont.systemFont(ofSize: 20, weight: .light)
    lbl.text = "00:10"
    
    view.addSubview(lbl)
    
    return lbl
  }()
  
  lazy var lblQuestion: UILabel = {
    let lbl = UILabel(frame: .zero)
    lbl.textAlignment = .center
    lbl.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    lbl.text = "Question placeholder"
    lbl.numberOfLines = 0
    
    view.addSubview(lbl)
    
    return lbl
  }()
  
  lazy var btnTrue: UIButton = {
    let btn = UIButton(type: .custom)
    btn.layer.cornerRadius = 12
    btn.backgroundColor = .green
    btn.setTitle("👍True", for: .normal)
    btn.setTitleColor(.black, for: .normal)
    btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
    btn.showsTouchWhenHighlighted = true
    btn.addTarget(self, action: #selector(handleAnswer(_:)), for: .touchUpInside)
    
    return btn
  }()
  
  lazy var btnFalse: UIButton = {
    let btn = UIButton(type: .custom)
    btn.layer.cornerRadius = 12
    btn.backgroundColor = .red
    btn.setTitle("👎False", for: .normal)
    btn.setTitleColor(.black, for: .normal)
    btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
    btn.showsTouchWhenHighlighted = true
    btn.addTarget(self, action: #selector(handleAnswer(_:)), for: .touchUpInside)
    
    return btn
  }()
  
  lazy var svButtons: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [btnFalse, btnTrue])
    stackView.alignment = .center
    stackView.spacing = 16
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    
    view.addSubview(stackView)
    
    return stackView
  }()
  
  lazy var lblMessage: UILabel = {
    let lbl = UILabel(frame: .zero)
    lbl.numberOfLines = 0
    lbl.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    lbl.textAlignment = .center
    lbl.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
    lbl.alpha = 0
    
    self.navigationController?.view.addSubview(lbl)
    
    return lbl
  }()
  
  // - MARK: Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 108.0/255, blue: 0, alpha: 1.0)
    navigationController?.navigationBar.isTranslucent = false
    
    setupConstraints()
    startGame()
  }
}

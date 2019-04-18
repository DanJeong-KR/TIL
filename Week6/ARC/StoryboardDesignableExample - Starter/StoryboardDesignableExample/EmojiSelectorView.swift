
import UIKit

@IBDesignable
final class EmojiSelectorView: UIView {
  
  let emojiDisplayLabel = UILabel()
  let upButton = UIButton(type: .system)
  let downButton = UIButton(type: .system)
    
  
  let emojis = [
    "😀", "😃", "😄", "😆", "😅",
    "🤲", "👐", "🙌", "👏", "🤝",
    "🐶", "🐱", "🐭", "🐹", "🐰"
  ]
  
  //var something: Int = 0
    
    
    @IBInspectable var currentIndex: Int = 0 {
        didSet {
            // currentIndex 에서 나누어서 떨어진 수로 계산하면
            // 15가 될때 15 % 15 가 되므로 0이 되서 다시 첫 이모지 (emojis[0])로 시작합니다.
            if self.currentIndex >= 0 {
                let index = self.currentIndex % (emojis.count)
                emojiDisplayLabel.text = emojis[index]
            } else {
                // 음수면 다시 양수로 바꿔서 계산합니다. abs() -> 절대값 구하는 함수.
                // currentIndex 가 음수가 되면 -1 부터 시작하기 때문에
                //(배열의 시작은 0 부터 시작해야함)
                // (abs(self.currentIndex)-1) 에서 -1 해줍니다.
                let index = (abs(self.currentIndex)-1) % (emojis.count)
                emojiDisplayLabel.text = emojis.reversed()[index]
            }
            print(self.currentIndex)
       }
    }
    
    @IBInspectable var emojiAreaRatio: CGFloat = 0.7 {
        didSet {
            let emojiWidth = frame.width * emojiAreaRatio
            emojiDisplayLabel.frame = CGRect(x: 0, y: 0, width: emojiWidth, height: frame.height)
        }
    }
    
    @IBInspectable var emojiLabelBgColor: UIColor? {
        get { return emojiDisplayLabel.backgroundColor }
        set { emojiDisplayLabel.backgroundColor = newValue }
    }
    
    @IBInspectable var emojiFontSize: CGFloat = 50 {
        didSet {
            emojiDisplayLabel.font = UIFont.systemFont(ofSize: self.emojiFontSize)
        }
    }
  
    //버튼들 배경색
    @IBInspectable var upButtonBgColor: UIColor? {
        get { return self.upButton.backgroundColor }
        set { upButton.backgroundColor = newValue }
    }
    @IBInspectable var downButtonBgColor: UIColor? {
        get { return downButton.backgroundColor }
        set { downButton.backgroundColor = newValue }
    }
    
    // 화살표 크기
    @IBInspectable var buttonFontSize: CGFloat = 30 {
        didSet {
            upButton.titleLabel?.font = UIFont.systemFont(ofSize: self.buttonFontSize)
            downButton.titleLabel?.font = UIFont.systemFont(ofSize: self.buttonFontSize)
        }
    }
    
    // 코드에서 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // 스토리보드 초기화
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        addSubview(emojiDisplayLabel)
        addSubview(upButton)
        addSubview(downButton)
        
        emojiDisplayLabel.text = emojis[currentIndex]
        emojiDisplayLabel.textAlignment = .center
        emojiDisplayLabel.font = UIFont.systemFont(ofSize: 50)
        
        upButton.setTitle("⬆︎", for: .normal)
        upButton.setTitleColor(.black, for: .normal)
        upButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        upButton.titleLabel?.textAlignment = .center
        upButton.layer.borderWidth = 1
        upButton.layer.borderColor = UIColor.black.cgColor
        upButton.addTarget(self, action: #selector(didTapUpDownButton(_:)), for: .touchUpInside)
        
        downButton.setTitle("⬇︎", for: .normal)
        downButton.setTitleColor(.black, for: .normal)
        downButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        downButton.titleLabel?.textAlignment = .center
        downButton.layer.borderWidth = 1
        downButton.layer.borderColor = UIColor.black.cgColor
        downButton.addTarget(self, action: #selector(didTapUpDownButton(_:)), for: .touchUpInside)
        
        
    }
  
  // MARK: - View Layout
  
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let emojiWidth = frame.width * emojiAreaRatio
        emojiDisplayLabel.frame = CGRect(x: 0, y: 0, width: emojiWidth, height: frame.height)
        
        upButton.frame = CGRect(x: emojiWidth, y: 0, width: frame.width - emojiWidth, height: frame.height / 2)
        
        downButton.frame = CGRect(x: emojiWidth, y: frame.height / 2, width: frame.width - emojiWidth, height: frame.height / 2)
    }
  
  
  // MARK: - Action Handler
  
  @objc func didTapUpDownButton(_ sender: UIButton) {
    switch sender.self {
    case upButton:
        currentIndex += 1
    case downButton:
        currentIndex -= 1
    default:
        break
    }
  }
  
}

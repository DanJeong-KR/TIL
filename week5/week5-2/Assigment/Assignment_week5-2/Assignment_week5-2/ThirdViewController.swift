/*
 
 3.
 - FirstVC 에 텍스트가 -1인 UILabel 과 SecondVC 를 띄우기 위한 UIButton 생성
 - SecondVC 에는 4개(10, 20, 30, 40)의 segment를 가진 UISegmentedControl,
 그리고 FirstVC 로 돌아가기 위한 UIButton 생성
 UISegmentedControl 에서 값을 선택한 뒤 버튼을 누르면 그 값이 FirstVC 의 Label 에 표시되도록 구현
 
 */

import UIKit

class ThirdViewController: UIViewController {
    
    var segValue: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segAction(_ sender: UISegmentedControl) {
        segValue = sender.titleForSegment(at: sender.selectedSegmentIndex)
    }
    
}

/*
 2. 스토리보드 이용할 것
 - FirstVC 에 Dog, Cat, Bird 라는 이름의 Button을 3개 만들고 숫자를 표시하기 위한 Label 하나 생성
 - SecondVC 에 UIImageView 하나와 Dismiss 를 위한 버튼 하나 생성
 - FirstVC에 있는 버튼 3개 중 하나를 누르면 그 타이틀에 맞는 이미지를 SecondVC의 ImageView 에 넣기
 (이미지는 구글링 등을 통해 활용)
 - 각 버튼별로 전환 횟수를 세서 개는 8회, 고양이는 10회, 새는 15회가 초과되면 화면이 전환되지 않도록 막기
 (전환 횟수가 초과된 버튼은 그것만 막고, 횟수가 초과되지 않은 버튼으로는 전환 가능)
 - 그리고 SecondVC 에 추가로 UIButton 을 하나 더 생성하여 그 버튼을 누를 때마다 전환 횟수를 계산하는 값이 개와 고양이, 새 모두에 대해 1회씩 추가되도록 구현
 */

/*
 3.
 - FirstVC 에 텍스트가 -1인 UILabel 과 SecondVC 를 띄우기 위한 UIButton 생성
 - SecondVC 에는 4개(10, 20, 30, 40)의 segment를 가진 UISegmentedControl,
 그리고 FirstVC 로 돌아가기 위한 UIButton 생성
 UISegmentedControl 에서 값을 선택한 뒤 버튼을 누르면 그 값이 FirstVC 의 Label 에 표시되도록 구현
 */

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var lb_dog: UILabel!
    var dogCount = 0
    @IBOutlet weak var lb_cat: UILabel!
    var catCount = 0
    @IBOutlet weak var lb_bird: UILabel!
    var birdCount = 0
    
    @IBOutlet weak var lb_third: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let bt = sender as! UIButton
        
        switch bt.currentTitle! {
        case "Dog":
            if dogCount >= 8 {
                return false
            }
        case "Cat":
            if catCount >= 10 {
                return false
            }
        case "Bird":
            if birdCount >= 15 {
                return false
            }
        default:
            return true
        }
        
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let secondVC = segue.destination as? SecondViewController else { return }
        switch segue.identifier {
        case "dog":
            secondVC.id = "dog"
            dogCount += 1
            //lb_dog.text = String(dogCount)
        case "cat":
            secondVC.id = "cat"
            catCount += 1
            //lb_cat.text = String(catCount)
        case "bird":
            secondVC.id = "bird"
            birdCount += 1
            //lb_bird.text = String(birdCount)
        default:
            print("잘못된 식별자")
        }
        lbSetting()
 
    }
    
    @IBAction func unwindToToFirstVC(_ unwindSegue: UIStoryboardSegue) {
        print(unwindSegue.identifier ?? "nil")
        
        print(unwindSegue.source is ThirdViewController)
        print(unwindSegue.source is SecondViewController)
        if unwindSegue.source is SecondViewController {
            guard let secondVC = unwindSegue.source as? SecondViewController else { return }
            dogCount += secondVC.clickCount
            catCount += secondVC.clickCount
            birdCount += secondVC.clickCount
            lbSetting()
        }else if unwindSegue.source is ThirdViewController {
            guard let thirdVC = unwindSegue.source as? ThirdViewController else { return }
            self.lb_third.text = thirdVC.segValue!
        }
    }
    
    
    //
    func lbSetting () -> () {
        lb_dog.text = String(dogCount)
        lb_cat.text = String(catCount)
        lb_bird.text = String(birdCount)
    }
}




/*
 
 데이트피커 , 알람 여부 저장하고
 돌아가기 버튼 눌렀을 때 돌아가는 걸로
 
 */
import UIKit

final class ViewController: UIViewController {

  @IBOutlet private weak var datePicker: UIDatePicker!
  @IBOutlet private weak var alertSwitch: UISwitch!
    
    let ud = UserDefaults.standard

  // MARK: Action Handler
  @IBAction func saveData(_ button: UIButton) {
    UserDefaults.standard.set(alertSwitch.isOn, forKey: "switch")
    UserDefaults.standard.set(datePicker.date, forKey: "date")
  }
  
  @IBAction func loadData(_ button: UIButton) {
    let dateInfo = ud.dictionaryRepresentation()["date"] as! Date
    print(dateInfo)
    
    let switchInfo = ud.dictionaryRepresentation()["switch"] as! Bool
    print(switchInfo)
    
    datePicker.setDate(dateInfo, animated: true)
    alertSwitch.isOn = switchInfo
    
  }
}


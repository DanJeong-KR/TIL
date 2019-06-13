//
//  TableViewCell.swift
//  WeatherForecast
//
//  Created by chang sic jung on 11/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    var weather: Weather? {
        didSet {
            guard let weather = self.weather else { return print("weather 가 nil 임")}
            
            self.dateLabel.text = weather.date
            self.timeLabel.text = weather.castTime
            self.weatherImageView.image = UIImage(named: weather.weatherImageCode ?? "에러")
            
            guard  let temp = weather.temperature else { return print("temp 가 nil")}
            self.tempLabel.text = (changeNumberFormatAndReturnString(numberStr: temp) ?? "0") + "°"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        
        [dateLabel, timeLabel, tempLabel].forEach { $0?.textColor = .white }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

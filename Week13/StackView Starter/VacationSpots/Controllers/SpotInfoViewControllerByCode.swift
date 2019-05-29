//
//  SpotInfoViewControllerByCode.swift
//  VacationSpots
//
//  Created by chang sic jung on 29/05/2019.
//  Copyright © 2019 Jawwad Ahmad. All rights reserved.
//

import UIKit

class SpotInfoViewControllerByCode: UIViewController {

    
    var vacationSpot: VacationSpot!
    
    var ratingInfo: Int? {
        didSet {
            var tempStr = ""
            for i in 0..<self.ratingInfo! {
                tempStr += "⭐️"
            }
            self.ratingInfoLabel.text = tempStr
        }
    }
    
    var ratingInfoLabel = UILabel()
    
    let weatherInfo = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var stackViews: [UIStackView] = []
        for i in 1...5 {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 0
            stackView.contentMode = .scaleToFill
            
            if i == 4 {
                stackView.axis = .horizontal
            }
            if i == 5 {
                stackView.axis = .horizontal
                stackView.distribution = .equalSpacing
            }
            
            stackViews.append(stackView)
        }
        
        let whyVisitLabel = UILabel()
        whyVisitLabel.text = "WHY VISIT"
        whyVisitLabel.backgroundColor = .yellow
        let whyVisitInfoLabel = UILabel()
        whyVisitInfoLabel.numberOfLines = 0
        whyVisitInfoLabel.text = "why visit info"
        stackViews[0].addArrangedSubview(whyVisitLabel)
        stackViews[0].addArrangedSubview(whyVisitInfoLabel)
        
        let weather = UILabel()
        weather.text = "weather"
        weather.backgroundColor = .red
        let hideBtn = UIButton(type: .system)
        hideBtn.setTitle("Hide", for: .normal)
        hideBtn.contentHorizontalAlignment = .left
        hideBtn.addTarget(self, action: #selector(hideButtonDidTapped(_:)), for: .touchUpInside)
        let weatherBtnStackView = UIStackView(arrangedSubviews: [weather,hideBtn])
        weatherBtnStackView.alignment = .leading
        weatherBtnStackView.axis = .horizontal
        weatherBtnStackView.distribution = .fillEqually
        weatherBtnStackView.spacing = 10
        
        weatherInfo.text = "weather Info"
        weatherInfo.numberOfLines = 0
        stackViews[1].addArrangedSubview(weatherBtnStackView)
        stackViews[1].addArrangedSubview(weatherInfo)
        
        let whatToSeeLabel = UILabel()
        whatToSeeLabel.text = "WHAT TO SEE"
        let whatToSeeInfoLabel = UILabel()
        whatToSeeInfoLabel.numberOfLines = 0
        whatToSeeInfoLabel.text = "what to see info"
        stackViews[2].addArrangedSubview(whatToSeeLabel)
        stackViews[2].addArrangedSubview(whatToSeeInfoLabel)
        
        let ratingLabel = UILabel()
        ratingLabel.text = "RATING"
        ratingInfoLabel.text = "⭐️⭐️⭐️⭐️⭐️"
        ratingLabel.backgroundColor = .red
        stackViews[3].distribution = .fillEqually
        stackViews[3].alignment = .center
        stackViews[3].addArrangedSubview(ratingLabel)
        stackViews[3].addArrangedSubview(ratingInfoLabel)
        
        let submitRatingBtn = UIButton(type: .system)
        submitRatingBtn.setTitle("Submit Rating", for: .normal)
        let viewMapBtn = UIButton(type: .system)
        viewMapBtn.setTitle("View Map", for: .normal)
        let wikipediaBtn = UIButton(type: .system)
        wikipediaBtn.setTitle("Wikipedia", for: .normal)
        stackViews[4].addArrangedSubview(submitRatingBtn)
        stackViews[4].addArrangedSubview(viewMapBtn)
        stackViews[4].addArrangedSubview(wikipediaBtn)
        
        
        let allStackView = UIStackView(arrangedSubviews: stackViews)
        allStackView.axis = .vertical
        allStackView.alignment = .fill
        allStackView.distribution = .fill
        allStackView.spacing = 20
        
        /////////////////////////////////////
        
        whyVisitInfoLabel.text = vacationSpot.whyVisit
        weatherInfo.text = vacationSpot.weatherInfo
        whatToSeeInfoLabel.text = vacationSpot.whatToSee
        ratingInfo = vacationSpot.userRating

        ///////////////////////////////////////

        view.addSubview(allStackView)

        // MARK: - AutoLayouts
        hideBtn.layout.heightAnchor.constraint(equalTo: weather.heightAnchor).isActive = true
        allStackView.layout.leading().top().trailing()
        
    }
    
    @objc private func hideButtonDidTapped(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            
            self.weatherInfo.isHidden = self.weatherInfo.isHidden ? false : true
            self.weatherInfo.alpha = self.weatherInfo.alpha == 1 ? 0 : 1
        }
    }
}

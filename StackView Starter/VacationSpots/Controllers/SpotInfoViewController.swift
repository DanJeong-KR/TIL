/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import SafariServices

class SpotInfoViewController: UIViewController {

  var vacationSpot: VacationSpot!

  @IBOutlet var backgroundColoredViews: [UIView]!
  @IBOutlet var headingLabels: [UILabel]!

  @IBOutlet weak var whyVisitLabel: UILabel!
  @IBOutlet weak var whatToSeeLabel: UILabel!
  @IBOutlet weak var weatherInfoLabel: UILabel!
  @IBOutlet weak var userRatingLabel: UILabel!
  @IBOutlet weak var weatherHideOrShowButton: UIButton!
  @IBOutlet weak var submitRatingButton: UIButton!

  var shouldHideWeatherInfoSetting: Bool {
    get {
      return UserDefaults.standard.bool(forKey: "shouldHideWeatherInfo")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "shouldHideWeatherInfo")
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Clear background colors from labels and buttons
    for view in backgroundColoredViews {
      view.backgroundColor = UIColor.clear
    }

    // Set the kerning to 1 to increase spacing between letters
    headingLabels.forEach { $0.attributedText = NSAttributedString(string: $0.text!, attributes: [NSAttributedStringKey.kern: 1]) }

    title = vacationSpot.name
    
    whyVisitLabel.text = vacationSpot.whyVisit
    whatToSeeLabel.text = vacationSpot.whatToSee
    weatherInfoLabel.text = vacationSpot.weatherInfo
    userRatingLabel.text = String(repeating: "★", count: vacationSpot.userRating)

    updateWeatherInfoViews(hideWeatherInfo: shouldHideWeatherInfoSetting, animated: false)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    let currentUserRating = UserDefaults.standard.integer(forKey: "currentUserRating-\(vacationSpot.identifier)")

    if currentUserRating > 0 {
      submitRatingButton.setTitle("Update Rating (\(currentUserRating))", for: UIControlState())
    } else {
      submitRatingButton.setTitle("Submit Rating", for: UIControlState())
    }
  }

  @IBAction func weatherHideOrShowButtonTapped(_ sender: UIButton) {
    let shouldHideWeatherInfo = sender.titleLabel!.text! == "Hide"
    updateWeatherInfoViews(hideWeatherInfo: shouldHideWeatherInfo, animated: true)
    shouldHideWeatherInfoSetting = shouldHideWeatherInfo
  }

  func updateWeatherInfoViews(hideWeatherInfo shouldHideWeatherInfo: Bool, animated: Bool) {
    let newButtonTitle = shouldHideWeatherInfo ? "Show" : "Hide"
    weatherHideOrShowButton.setTitle(newButtonTitle, for: UIControlState())

    UIView.animate(withDuration: 0.3) {
        self.weatherInfoLabel.isHidden = shouldHideWeatherInfo
    }
    
    // TODO: Animate when animated == true
    //weatherInfoLabel.isHidden = shouldHideWeatherInfo
  }

  @IBAction func wikipediaButtonTapped(_ sender: UIButton) {
    let safariVC = SFSafariViewController(url: vacationSpot.wikipediaURL as URL)
    safariVC.delegate = self
    present(safariVC, animated: true, completion: nil)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier! {
    case "presentMapViewController":
      guard let navigationController = segue.destination as? UINavigationController,
        let mapViewController = navigationController.topViewController as? MapViewController else {
          fatalError("Unexpected view hierarchy")
      }
      mapViewController.locationToShow = vacationSpot.coordinate
      mapViewController.title = vacationSpot.name
    case "presentRatingViewController":
      guard let navigationController = segue.destination as? UINavigationController,
        let ratingViewController = navigationController.topViewController as? RatingViewController else {
          fatalError("Unexpected view hierarchy")
      }
      ratingViewController.vacationSpot = vacationSpot
    default:
      fatalError("Unhandled Segue: \(segue.identifier!)")
    }
  }
}

// MARK: - SFSafariViewControllerDelegate

extension SpotInfoViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}

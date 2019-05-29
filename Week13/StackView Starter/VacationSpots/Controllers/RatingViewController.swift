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

class RatingViewController: UIViewController {

  var vacationSpot: VacationSpot!

  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet var ratingButtons: [UIButton]!
  @IBOutlet weak var starsStackView: UIStackView!
  @IBOutlet weak var submitRatingButton: UIButton!
  @IBOutlet weak var deleteRatingButton: UIButton!

  var currentUserRating: Int {
    get {
      return UserDefaults.standard.integer(forKey: "currentUserRating-\(vacationSpot.identifier)")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "currentUserRating-\(vacationSpot.identifier)")
    }
  }

  fileprivate let ratingButtonTitles = ["Boring", "Meh", "It's Ok", "Like It", "Fantastic!"]

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    // Clear storyboard background colors
    for button in ratingButtons {
      button.backgroundColor = UIColor.clear
    }

    questionLabel.text = "How would you rate \(vacationSpot.name)?"

    showStarCount(currentUserRating, animated: false)

    deleteRatingButton.isHidden = currentUserRating == 0

    if currentUserRating > 0 {
      submitRatingButton.setTitle("Update Your Rating", for: UIControlState())
      let index = currentUserRating - 1
      let titleOfButtonToSelect = ratingButtonTitles[index]
      for ratingButton in ratingButtons {
        ratingButton.isSelected = ratingButton.titleLabel!.text! == titleOfButtonToSelect
      }
    }
  }

  // MARK: - Actions

  @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction func submitRatingTapped() {
    currentUserRating = starsStackView.arrangedSubviews.count
    dismiss(animated: true, completion: nil)
  }

  @IBAction func deleteRatingTapped() {
    currentUserRating = 0
    dismiss(animated: true, completion: nil)
  }

  @IBAction func ratingButtonTapped(_ sender: UIButton) {
    let buttonTitle = sender.titleLabel!.text!

    // Select the tapped button and unselect others
    for ratingButton in ratingButtons {
      ratingButton.isSelected = ratingButton == sender
    }

    let rating = ratingForButtonTitle(buttonTitle)
    showStarCount(rating)
  }

  // MARK: - Helper Methods

  func ratingForButtonTitle(_ buttonTitle: String) -> Int {
    guard let index = ratingButtonTitles.index(of: buttonTitle) else {
      fatalError("Rating not found for buttonTitle: \(buttonTitle)")
    }
    return index + 1
  }

  func showStarCount(_ totalStarCount: Int, animated: Bool = true) {
    let starsToAdd = totalStarCount - starsStackView.arrangedSubviews.count

    if starsToAdd > 0 {
      for _ in 1...starsToAdd {
        let starImageView = UIImageView(image: UIImage(named: "rating_star"))
        starImageView.contentMode = .scaleAspectFit
        starImageView.frame.origin = CGPoint(x: starsStackView.frame.width, y: 0) // animate in from the right
        starsStackView.addArrangedSubview(starImageView)
      }
    } else if starsToAdd < 0 {
      let starsToRemove = abs(starsToAdd)

      for _ in 1...starsToRemove {
        guard let star = starsStackView.arrangedSubviews.last else { fatalError("Unexpected Logic Error") }
        star.removeFromSuperview() // No need to call removeArrangedSubview separately
      }
    }

    if animated {
      UIView.animate(withDuration: 0.25, animations: {
        self.starsStackView.layoutIfNeeded()
      }) 
    }
  }
}

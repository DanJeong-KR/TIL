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
import MapKit

class SpotsViewController: UITableViewController {

    
    
  var vacationSpots = [VacationSpot]()

  // MARK: - Lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()

    vacationSpots = VacationSpot.loadAllVacationSpots()
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return vacationSpots.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "VacationSpotCell", for: indexPath) as! VacationSpotCell
    let vacationSpot = vacationSpots[indexPath.row]
    cell.nameLabel.text = vacationSpot.name
    cell.locationNameLabel.text = vacationSpot.locationName
    cell.thumbnailImageView.image = UIImage(named: vacationSpot.thumbnailName)

    return cell
  }

  // MARK: - Navigation

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let selectedCell = sender as? UITableViewCell, let selectedRowIndex = tableView.indexPath(for: selectedCell)?.row, segue.identifier == "showSpotInfoViewController" else {
        fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
    }

    let vacationSpot = vacationSpots[selectedRowIndex]
    let detailViewController = segue.destination as! SpotInfoViewControllerByCode
    detailViewController.vacationSpot = vacationSpot
  }
}

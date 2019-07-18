import Foundation
import UIKit


let colors: [UIColor] = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]

struct Card {
  let color: UIColor
}

var cards: [Card] = [
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
//  Card(color: colors.randomElement()!),
]


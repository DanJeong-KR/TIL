import UIKit


struct Section {
  var cards: [Card]
}

var sections: [Section] = [
  Section(cards: cards.shuffled()),
  Section(cards: cards.shuffled()),
  Section(cards: cards.shuffled()),
  Section(cards: cards.shuffled()),
  Section(cards: cards.shuffled()),
]


import Foundation

struct Question {
  let title: String
  let isTrue: Bool
}

let questions = [
  ("As far as has ever been reported, no-one has ever seen an ostrich bury its head in the sand.", true),
  ("Approximately one quarter of human bones are in the feet.", true),
  ("Popeye’s nephews were called Peepeye, Poopeye, Pipeye and Pupeye.", true),
].map(Question.init)



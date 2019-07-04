
import Foundation

// MARK: - Game State
extension QuizViewController {
  struct State {
    let questions: [Question]
    let numberOfQuestions: Int
    var currentQuestion: Int
    var correctAnswers: Int
    
    init(questions: [Question]) {
      self.questions = questions
      numberOfQuestions = questions.count
      currentQuestion = 1
      correctAnswers = 0
    }
    
    var isLastQuestion: Bool {
      return currentQuestion == numberOfQuestions
    }
    
    var question: Question {
      return questions[currentQuestion - 1]
    }
  }
}

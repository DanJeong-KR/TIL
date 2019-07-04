

import UIKit
import SnapKit

extension QuizViewController {
  
  
  func setupConstraints() {
    guard let navView = navigationController?.view else { return }

//    viewProgress.translatesAutoresizingMaskIntoConstraints = false
//
//    NSLayoutConstraint.activate([
//      viewProgress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//      viewProgress.heightAnchor.constraint(equalToConstant: 32),
//      viewProgress.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//      ])

    updateProgress(to: 0)

//    lblTimer.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//        lblTimer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
//        lblTimer.heightAnchor.constraint(equalToConstant: 45),
//        lblTimer.topAnchor.constraint(equalTo: viewProgress.bottomAnchor, constant: 32),
//        lblTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//    ])
    
    
    lblTimer.snp.makeConstraints { make in
      make.width.equalToSuperview().multipliedBy(0.45)
      make.height.equalTo(45)
      make.top.equalTo(viewProgress.snp.bottom).offset(32)
      make.centerX.equalToSuperview()
    }
    
    
//    lblQuestion.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//        lblQuestion.topAnchor.constraint(equalTo: lblTimer.bottomAnchor, constant: 24),
//        lblQuestion.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//        lblQuestion.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
//    ])
    
    lblQuestion.snp.makeConstraints{ make in
      make.top.equalTo(lblTimer.snp.bottom).offset(24)
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 16,
                                                                                 left: 16,
                                                                                 bottom: 16,
                                                                                 right: 16))
    }

//    lblMessage.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//        lblMessage.topAnchor.constraint(equalTo: navView.topAnchor),
//        lblMessage.bottomAnchor.constraint(equalTo: navView.bottomAnchor),
//        lblMessage.leadingAnchor.constraint(equalTo: navView.leadingAnchor),
//        lblMessage.trailingAnchor.constraint(equalTo: navView.trailingAnchor)
//    ])
    
    lblMessage.snp.makeConstraints{ make in
      make.edges.equalToSuperview()
    }

//    svButtons.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//        svButtons.leadingAnchor.constraint(equalTo: lblQuestion.leadingAnchor),
//        svButtons.trailingAnchor.constraint(equalTo: lblQuestion.trailingAnchor),
//        svButtons.topAnchor.constraint(equalTo: lblQuestion.bottomAnchor, constant: 16),
//        svButtons.heightAnchor.constraint(equalToConstant: 80)
//    ])
    
    svButtons.snp.makeConstraints{ make in
      make.leading.trailing.equalTo(lblQuestion)
      make.top.equalTo(lblQuestion.snp.bottom).offset(16)
      make.height.equalTo(80)
    }
    
    
  }
  
  
  func updateProgress(to progress: Double) {
//    // 먼저 Constraints 비활성화 시키고
//    if let constraint = progressConstraint {
//      constraint.isActive = false
//    }
//    // 다시 잡기
//    progressConstraint = viewProgress.widthAnchor.constraint(equalTo: view.widthAnchor,
//                                                             multiplier: CGFloat(progress))
//    progressConstraint.isActive = true
    
    viewProgress.snp.remakeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.width.equalToSuperview().multipliedBy(progress)
      make.height.equalTo(32)
      make.leading.equalToSuperview()
    }
  }

}

extension QuizViewController {
  
  override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    super.willTransition(to: newCollection, with: coordinator)
    
    let isPortrait = UIDevice.current.orientation.isPortrait
    
    lblTimer.snp.updateConstraints { make in
      make.height.equalTo(isPortrait ? 45 : 65)
    }
    lblTimer.font = UIFont.systemFont(ofSize: isPortrait ? 20 : 32, weight: .light)
  }
}

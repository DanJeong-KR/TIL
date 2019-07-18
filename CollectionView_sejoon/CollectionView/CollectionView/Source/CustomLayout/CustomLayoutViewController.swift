import UIKit

final class CustomLayoutViewController: UIViewController {

  // MARK: - Property
  var source: [Card] = cards + cards
  
  // UI
  lazy var collectionView: UICollectionView = {
    let layout = self.pinteresLayout
    layout.delegate = self
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    collectionView.delegate = self
    return collectionView
  }()
  
  let pinteresLayout = PinterestLayout()
  let flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: 100, height: 100)
    layout.minimumLineSpacing = 5.0
    layout.minimumInteritemSpacing = 5.0
    return layout
  }()
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    configureCollectionView()
    configureNavigationBarButton()
  }
  
  // MARK: - Configure
  
  private func configureCollectionView() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
  }
  
  private func configureNavigationBarButton() {
    let transitionButton = UIBarButtonItem(title: "Transition", style: .done, target: self, action: #selector(onTapTransitionButton))
    self.navigationItem.rightBarButtonItem = transitionButton
  }
  
  @objc private func onTapTransitionButton(_ sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: "CollectionView Layout Transition", message: nil, preferredStyle: .actionSheet)
    
    let pinterestWithoutAnimate = UIAlertAction(title: "핀터레스트 Layout without animate", style: .default) { [weak self] _ in
      guard let self = self else { return }
      self.collectionView.setCollectionViewLayout(self.pinteresLayout, animated: false)
    }
    let flowWithoutAnimte = UIAlertAction(title: "플로우 Layout without animate", style: .default) { [weak self] _ in
      guard let self = self else { return }
      self.collectionView.setCollectionViewLayout(self.flowLayout, animated: false)
    }
    let pinterestWithAnimate = UIAlertAction(title: "핀터레스트 Layout with animate", style: .default) { [weak self] _ in
      guard let self = self else { return }
      self.collectionView.setCollectionViewLayout(self.pinteresLayout, animated: true)
    }
    let flowWithAnimte = UIAlertAction(title: "플로우 Layout with animate", style: .default) { [weak self] _ in
      guard let self = self else { return }
      self.collectionView.setCollectionViewLayout(self.flowLayout, animated: true)
    }
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
    
    alertController.addAction(pinterestWithoutAnimate)
    alertController.addAction(flowWithoutAnimte)
    alertController.addAction(pinterestWithAnimate)
    alertController.addAction(flowWithAnimte)
    alertController.addAction(cancelAction)
    
    present(alertController, animated: true)
  }
}

// MARK: - UICollectionViewDataSource

extension CustomLayoutViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return source.count }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.contentView.layer.cornerRadius = 5.0
    cell.contentView.backgroundColor = source[indexPath.item].color
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension CustomLayoutViewController: PinterestLayoutDelegate {
  
  func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
    return 100 + CGFloat.random(in: 20..<150)
  }
}

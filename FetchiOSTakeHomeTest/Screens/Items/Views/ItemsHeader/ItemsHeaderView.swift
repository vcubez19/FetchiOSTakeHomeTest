//
//  ItemsHeaderView.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/5/24.
//

import UIKit

protocol ItemsHeaderViewDelegate: AnyObject {
  func didTapListWithId(_ id: Int)
}

final class ItemsHeaderView: UIView {
  
  // MARK: Stored properties
  
  let itemsListViewModel: ItemsListViewModel
  
  private let listsCollectionView: UICollectionView = {
    let listsCollectionViewLayout = UICollectionViewFlowLayout()
//    listsCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    listsCollectionViewLayout.itemSize = CGSize(width: 100.0, height: 100.0)
    listsCollectionViewLayout.scrollDirection = .horizontal
    
    let listsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: listsCollectionViewLayout)
    
    listsCollectionView.translatesAutoresizingMaskIntoConstraints = false
    listsCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.reuseID)
    
    return listsCollectionView
  }()
  
  weak var delegate: ItemsHeaderViewDelegate?
  
  // MARK: View lifecycle
  
  init(frame: CGRect, itemsListViewModel: ItemsListViewModel) {
    self.itemsListViewModel = itemsListViewModel
    super.init(frame: frame)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Methods
  
  private func setupView() {
    addSubview(listsCollectionView)
    listsCollectionView.delegate = self
    listsCollectionView.dataSource = self
    
    NSLayoutConstraint.activate([
      listsCollectionView.topAnchor.constraint(equalTo: topAnchor),
      listsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      listsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      listsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    
    listsCollectionView.reloadData()
  }
}

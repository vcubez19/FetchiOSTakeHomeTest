//
//  ListCollectionViewCell.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/5/24.
//

import UIKit

/// A view that displays a list's name.

final class ListCollectionViewCell: UICollectionViewCell {
  
  // MARK: Stored properties
  
  static var reuseID: String {
    return String(describing: self)
  }
  
  private let listButton: UIButton = {
    var listButtonConfiguration = UIButton.Configuration.tinted()
    listButtonConfiguration.cornerStyle = .capsule
    
    let listButton = UIButton()
    listButton.configuration = listButtonConfiguration
    listButton.isUserInteractionEnabled = false
    listButton.translatesAutoresizingMaskIntoConstraints = false
    
    return listButton
  }()
  
  // MARK: View lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Methods
  
  private func setupView() {
    contentView.addSubview(listButton)
    NSLayoutConstraint.activate([
      listButton.topAnchor.constraint(equalTo: contentView.topAnchor),
      listButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      listButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      listButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
  func setList(_ listName: String) {
    listButton.configuration?.title = listName
  }
}

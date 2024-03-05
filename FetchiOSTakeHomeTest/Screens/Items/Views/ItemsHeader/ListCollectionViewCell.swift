//
//  ListCollectionViewCell.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/5/24.
//

import UIKit

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
      listButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      listButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
      listButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0)
    ])
  }
  
  func setList(_ listName: String) {
    listButton.configuration?.title = listName
  }
}

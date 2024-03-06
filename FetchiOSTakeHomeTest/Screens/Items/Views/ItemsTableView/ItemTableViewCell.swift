//
//  ItemTableViewCell.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import UIKit

/// A cell that displays an Item's name from the server.

final class ItemTableViewCell: UITableViewCell {
  
  // MARK: Stored properties
  
  static var reuseID: String {
    return String(describing: self)
  }
  
  private let itemNameLabel: UILabel = {
    let itemNameLabel = UILabel()
    itemNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
    itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    return itemNameLabel
  }()
  
  private let itemListNameView: UIButton = {
    var itemListNameViewConfiguration = UIButton.Configuration.tinted()
    itemListNameViewConfiguration.cornerStyle = .capsule
    
    let itemListNameView = UIButton()
    itemListNameView.isHidden = true
    itemListNameView.isUserInteractionEnabled = false
    itemListNameView.configuration = itemListNameViewConfiguration
    itemListNameView.translatesAutoresizingMaskIntoConstraints = false
    
    return itemListNameView
  }()
    
  // MARK: View lifecycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Methods
  
  private func setupView() {
    contentView.addSubview(itemNameLabel)
    contentView.addSubview(itemListNameView)
        
    NSLayoutConstraint.activate([
      itemNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
      itemNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      itemListNameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
      itemListNameView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
  
  func setItemText(_ itemText: String?) {
    itemNameLabel.text = itemText
  }
  
  func setItemListName(_ listName: String?) {
    itemListNameView.isHidden = false
    itemListNameView.configuration?.title = listName
  }
}

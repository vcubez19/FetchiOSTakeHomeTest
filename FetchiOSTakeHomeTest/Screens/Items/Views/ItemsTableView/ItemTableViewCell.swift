//
//  ItemTableViewCell.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import UIKit

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
  
  // MARK: View lifecycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layoutView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Methods
  
  private func layoutView() {
    contentView.addSubview(itemNameLabel)
    
    NSLayoutConstraint.activate([
      itemNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
      itemNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
  
  func setItemText(_ itemText: String?) {
    itemNameLabel.text = itemText
  }
}

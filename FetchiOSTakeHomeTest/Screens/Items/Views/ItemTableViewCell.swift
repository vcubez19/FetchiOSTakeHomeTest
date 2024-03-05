//
//  ItemTableViewCell.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
  
  static var reuseID: String {
    return String(describing: self)
  }
  
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
    
  }
}

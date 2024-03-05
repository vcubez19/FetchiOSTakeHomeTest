//
//  ItemsHeaderViewDelegate.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/5/24.
//

import Foundation

extension ItemsViewController: ItemsHeaderViewDelegate {
  func didTapListWithId(_ id: Int) {
    let destinationIndexPath = IndexPath(row: 0, section: id - 1)
    tableView.scrollToRow(at: destinationIndexPath, at: .top, animated: true)
  }
}

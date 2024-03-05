//
//  ItemsTableViewDataSource.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import Foundation
import UIKit

extension ItemsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return itemsListViewModel.listsCount
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemsListViewModel.numberOfItemsInListAtIndex(section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseID, for: indexPath) as! ItemTableViewCell
    
    let itemName = itemsListViewModel.itemAtIndexPath(indexPath.section, row: indexPath.row)
    
    cell.setItemText(itemName)
    
    return cell
  }
}

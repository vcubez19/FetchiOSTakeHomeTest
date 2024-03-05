//
//  ItemsTableViewControllerDelegate.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import Foundation
import UIKit

extension ItemsTableViewController {
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50.0
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ListSectionView.reuseID) as! ListSectionView
    
    let list = itemsListViewModel.listNameAtIndex(section)
    let numberOfItemsInList = itemsListViewModel.numberOfItemsInListAtIndex(section)
    
    header.setSectionName(list)
    header.setNumberOfItemsInSection(numberOfItemsInList)
    
    return header
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50.0
  }
}

//
//  ItemSearchBarDelegate.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/5/24.
//

import Foundation
import UIKit

extension ItemsViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    itemsListViewModel.setFilteredItemsListWithSearchText(searchText)
    itemSearchResultsController.tableView.reloadData()
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.placeholder = ItemSearchBarPlaceholder.editing.rawValue
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.placeholder = ItemSearchBarPlaceholder.notEditing.rawValue
  }
}

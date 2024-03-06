//
//  ItemSearchResultsViewController.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/6/24.
//

import UIKit

final class ItemSearchResultsViewController: UITableViewController {

  // MARK: Stored properties
  
  private let itemsListViewModel: ItemsListViewModel
  
  // MARK: View lifecycle
  
  init(itemsListViewModel: ItemsListViewModel) {
    self.itemsListViewModel = itemsListViewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: Methods
  
  private func setupView() {
    tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.reuseID)
  }
  
  // MARK: Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemsListViewModel.filteredItemsCount
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseID, for: indexPath) as! ItemTableViewCell
    
    let itemName = itemsListViewModel.filteredItemAtIndex(indexPath.row)
    
    cell.setItemText(itemName)
    
    return cell
  }
  
  // MARK: Table view delegate
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50.0
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

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
  
  private let noSearchResultsView: UIButton = {
    var noSearchResultsViewConfiguration = UIButton.Configuration.tinted()
    noSearchResultsViewConfiguration.cornerStyle = .capsule
    
    let noSearchResultsView = UIButton()
    noSearchResultsView.isUserInteractionEnabled = false
    noSearchResultsView.isHidden = true
    noSearchResultsView.configuration = noSearchResultsViewConfiguration
    noSearchResultsView.translatesAutoresizingMaskIntoConstraints = false
    
    return noSearchResultsView
  }()
  
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
    
    itemsListViewModel.noSearchResultsListener = { [weak self] empty in
      
      guard let strongSelf = self else { return }
      
      DispatchQueue.main.async {
        strongSelf.noSearchResultsView.isHidden = !empty
        
        if empty {
          let searchText = strongSelf.itemsListViewModel.getSearchBarText()
          strongSelf.noSearchResultsView.configuration?.title = "No results for \(searchText)"
        }
      }
    }
    
    view.addSubview(noSearchResultsView)
    NSLayoutConstraint.activate([
      noSearchResultsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44.0),
      noSearchResultsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      noSearchResultsView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 40.0),
      noSearchResultsView.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -40.0)
    ])
  }
  
  // MARK: Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemsListViewModel.filteredItemsCount
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseID, for: indexPath) as! ItemTableViewCell
    
    let item = itemsListViewModel.filteredItemAtIndex(indexPath.row)
    cell.setItemText(item.name)
    
    let listLocationName = itemsListViewModel.listLocationForItem(item)
    cell.setItemListName(listLocationName)
    
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

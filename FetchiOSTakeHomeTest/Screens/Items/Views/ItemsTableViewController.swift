//
//  ItemsTableViewController.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import UIKit

final class ItemsTableViewController: UITableViewController {
  
  // MARK: Stored properties
  
  let itemsListViewModel: ItemsListViewModel = ItemsListViewModel()
  
  private let itemsLoadingIndicatorView: UIActivityIndicatorView = {
    let itemsLoadingIndicatorView = UIActivityIndicatorView()
    itemsLoadingIndicatorView.hidesWhenStopped = true
    itemsLoadingIndicatorView.color = .label
    itemsLoadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    
    return itemsLoadingIndicatorView
  }()
  
  private let refreshView: RefreshView = {
    let refreshView = RefreshView()
    refreshView.setInformationLabelText("Something went wrong.")
    refreshView.setRefreshButtonText("Refresh")
    refreshView.isHidden = true
    refreshView.translatesAutoresizingMaskIntoConstraints = false
    
    return refreshView
  }()
  
  private var itemsHeaderView: ItemsHeaderView!
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupView()
    fetchItems()
  }
  
  // MARK: Methods
  
  private func setupNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Items"
  }
  
  private func setupView() {
    tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.reuseID)
    tableView.register(ListSectionView.self, forHeaderFooterViewReuseIdentifier: ListSectionView.reuseID)
    
    view.addSubview(itemsLoadingIndicatorView)
    view.addSubview(refreshView)
    refreshView.delegate = self
    
    itemsListViewModel.fetchItemsFailedListener = { [weak self] fetchFailed in
      DispatchQueue.main.async {
        self?.refreshView.isHidden = !fetchFailed
      }
    }
    
    NSLayoutConstraint.activate([
      itemsLoadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      itemsLoadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      refreshView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44.0),
      refreshView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      refreshView.heightAnchor.constraint(equalToConstant: 100.0)
    ])
  }
  
  @MainActor
  private func fetchItems() {
    Task {
      itemsLoadingIndicatorView.startAnimating()
      
      await itemsListViewModel.fetchItems()
      
      tableView.reloadData()
      itemsLoadingIndicatorView.stopAnimating()
    }
  }
}

// MARK: RefreshViewDelegate

extension ItemsTableViewController: RefreshViewDelegate {
  func didTapRefreshButton(_ button: UIButton) {
    Task {
      button.configuration?.showsActivityIndicator = true
      button.isEnabled = false
      
      await itemsListViewModel.fetchItems()
      
      self.tableView.reloadData()
      button.configuration?.showsActivityIndicator = false
      button.isEnabled = true
    }
  }
}

//
//  ItemsTableViewController.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import UIKit

final class ItemsViewController: UIViewController {
  
  // MARK: Stored properties
  
  let itemsListViewModel: ItemsListViewModel = ItemsListViewModel()
  
  let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.reuseID)
    tableView.register(ListSectionView.self, forHeaderFooterViewReuseIdentifier: ListSectionView.reuseID)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    return tableView
  }()
  
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
  
  var itemSearchResultsController: ItemSearchResultsViewController!
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupHeader()
    setupView()
    fetchItems()
  }
  
  // MARK: Methods
  
  private func setupNavigationBar() {
    navigationController?.navigationBar.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Items"

    itemSearchResultsController = ItemSearchResultsViewController(itemsListViewModel: itemsListViewModel)
    
    navigationItem.searchController = UISearchController(searchResultsController: itemSearchResultsController)
    navigationItem.searchController?.searchBar.placeholder = "Find an item"
    navigationItem.searchController?.searchBar.keyboardType = .numberPad
    navigationItem.searchController?.searchBar.delegate = self
  }
  
  private func setupHeader() {
    itemsHeaderView = ItemsHeaderView(frame: .zero, itemsListViewModel: itemsListViewModel)
    itemsHeaderView.translatesAutoresizingMaskIntoConstraints = false
    
    itemsHeaderView.delegate = self

    view.addSubview(itemsHeaderView)
    
    NSLayoutConstraint.activate([
      itemsHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      itemsHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      itemsHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      itemsHeaderView.heightAnchor.constraint(equalToConstant: 50.0)
    ])
  }
  
  private func setupView() {

    view.backgroundColor = .systemBackground
    
    view.addSubview(tableView)
    view.addSubview(itemsLoadingIndicatorView)
    view.addSubview(refreshView)
    
    tableView.delegate = self
    tableView.dataSource = self
    refreshView.delegate = self
    
    itemsListViewModel.fetchItemsFailedListener = { [weak self] fetchFailed in
      DispatchQueue.main.async {
        self?.refreshView.isHidden = !fetchFailed
      }
    }
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: itemsHeaderView.bottomAnchor, constant: 8.0),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      itemsLoadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      itemsLoadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      refreshView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44.0),
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
      itemsHeaderView.listsCollectionView.reloadData()
      
      itemsLoadingIndicatorView.stopAnimating()
    }
  }
}

// MARK: RefreshViewDelegate

extension ItemsViewController: RefreshViewDelegate {
  func didTapRefreshButton(_ button: UIButton) {
    Task {
      button.configuration?.showsActivityIndicator = true
      button.isEnabled = false
      
      try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
      await itemsListViewModel.fetchItems()
      
      self.tableView.reloadData()
      itemsHeaderView.listsCollectionView.reloadData()

      button.configuration?.showsActivityIndicator = false
      button.isEnabled = true
    }
  }
}

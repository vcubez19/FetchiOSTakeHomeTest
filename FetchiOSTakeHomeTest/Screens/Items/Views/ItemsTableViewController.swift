//
//  ItemsTableViewController.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import UIKit

final class ItemsTableViewController: UITableViewController {
  
  // MARK: Stored properties
  
  private let itemsListViewModel: ItemsListViewModel = ItemsListViewModel()
  
  private let itemsLoadingIndicatorView: UIActivityIndicatorView = {
    let itemsLoadingIndicatorView = UIActivityIndicatorView()
    itemsLoadingIndicatorView.hidesWhenStopped = true
    itemsLoadingIndicatorView.color = .label
    itemsLoadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    
    return itemsLoadingIndicatorView
  }()
    
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
    
    let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapSettingsButton))
    settingsButton.tintColor = .label
    navigationItem.rightBarButtonItem = settingsButton
  }
  
  private func setupView() {
    tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.reuseID)
    
    view.addSubview(itemsLoadingIndicatorView)
    
    NSLayoutConstraint.activate([
      itemsLoadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      itemsLoadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  private func fetchItems() {
    Task {
      itemsLoadingIndicatorView.startAnimating()
      await itemsListViewModel.fetchItems()
      itemsLoadingIndicatorView.stopAnimating()
    }
  }
  
  // MARK: Actions
  
  @objc private func didTapSettingsButton() {
    let settingsViewController = SettingsViewController()
    navigationController?.pushViewController(settingsViewController, animated: true)
  }
}

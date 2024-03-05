//
//  ListSectionView.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/5/24.
//

import UIKit

final class ListSectionView: UITableViewHeaderFooterView {

  // MARK: Stored properties

  static var reuseID: String {
    return String(describing: self)
  }
  
  private let sectionNameLabel: UILabel = {
    let sectionNameLabel = UILabel()
    sectionNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    sectionNameLabel.font = UIFont.boldSystemFont(ofSize: sectionNameLabel.font.pointSize)
    sectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    return sectionNameLabel
  }()
  
  private let numberOfItemsInSectionView: UIButton = {
    var numberOfItemsInSectionViewConfiguration = UIButton.Configuration.tinted()
    numberOfItemsInSectionViewConfiguration.cornerStyle = .capsule
    numberOfItemsInSectionViewConfiguration.baseBackgroundColor = .black
    numberOfItemsInSectionViewConfiguration.baseForegroundColor = .white
    
    let numberOfItemsInSectionView = UIButton()
    numberOfItemsInSectionView.isUserInteractionEnabled = false
    numberOfItemsInSectionView.configuration = numberOfItemsInSectionViewConfiguration
    numberOfItemsInSectionView.translatesAutoresizingMaskIntoConstraints = false
    
    return numberOfItemsInSectionView
  }()
  
  // MARK: View lifecycle
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Methods
  
  private func setupView() {
    
    contentView.backgroundColor = .app
    
    contentView.addSubview(sectionNameLabel)
    contentView.addSubview(numberOfItemsInSectionView)
    
    NSLayoutConstraint.activate([
      sectionNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      sectionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
      
      numberOfItemsInSectionView.leadingAnchor.constraint(equalTo: sectionNameLabel.trailingAnchor, constant: 8.0),
      numberOfItemsInSectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
  
  func setSectionName(_ sectionName: String) {
    sectionNameLabel.text = sectionName
  }
  
  func setNumberOfItemsInSection(_ numberOfItems: Int) {
    numberOfItemsInSectionView.configuration?.title = String(numberOfItems)
  }
}

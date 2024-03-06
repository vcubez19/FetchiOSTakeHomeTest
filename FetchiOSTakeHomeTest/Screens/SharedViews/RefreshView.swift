//
//  RefreshView.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import UIKit

protocol RefreshViewDelegate: AnyObject {
  @MainActor
  func didTapRefreshButton(_ button: UIButton)
}

/// A view that shows a label on top of a refresh button.

final class RefreshView: UIView {
  
  // MARK: Stored properties
  
  private let informationLabel: UILabel = {
    let informationLabel = UILabel()
    informationLabel.translatesAutoresizingMaskIntoConstraints = false
    
    return informationLabel
  }()
  
  private let refreshButton: UIButton = {
    var refreshButtonConfiguration = UIButton.Configuration.tinted()
    refreshButtonConfiguration.imagePadding = 4.0
    refreshButtonConfiguration.image = UIImage(systemName: "arrow.clockwise.circle.fill")
    refreshButtonConfiguration.cornerStyle = .capsule
    
    let button = UIButton()
    button.configuration = refreshButtonConfiguration
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  weak var delegate: RefreshViewDelegate?
  
  // MARK: View lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Methods
  
  private func setupView() {
    addSubview(informationLabel)
    addSubview(refreshButton)
    
    NSLayoutConstraint.activate([
      informationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4.0),
      informationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.0),
      informationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4.0),
      
      refreshButton.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 8.0),
      refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
    
    refreshButton.addTarget(self, action: #selector(didTapRefreshButton), for: .touchUpInside)
  }
  
  func setInformationLabelText(_ labelText: String) {
    informationLabel.text = labelText
  }
  
  func setRefreshButtonText(_ buttonText: String) {
    refreshButton.configuration?.title = buttonText
  }
  
  // MARK: Actions
  
  @objc private func didTapRefreshButton(_ sender: UIButton) {
    delegate?.didTapRefreshButton(sender)
  }
}

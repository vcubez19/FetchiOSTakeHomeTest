//
//  ItemsHeaderViewDataSource.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/5/24.
//

import Foundation
import UIKit

extension ItemsHeaderView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemsListViewModel.listsCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseID, for: indexPath) as! ListCollectionViewCell
    
    let list = itemsListViewModel.listNameAtIndex(indexPath.section)
    cell.setList(list)
    
    return cell
  }
}

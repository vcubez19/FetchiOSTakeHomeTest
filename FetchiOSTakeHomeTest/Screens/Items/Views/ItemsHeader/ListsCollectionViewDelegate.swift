//
//  ListsCollectionViewDelegate.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/5/24.
//

import Foundation
import UIKit

extension ItemsHeaderView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let list = itemsListViewModel.listIdAtIndex(indexPath.item)
    delegate?.didTapListWithId(list)
  }
}

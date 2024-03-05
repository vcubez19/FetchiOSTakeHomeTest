//
//  ItemsListViewModel.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import Foundation
import os

final class ItemsListViewModel {
  
  private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!,
                                     category: String(describing: ItemsListViewModel.self))
  
  private var itemsList: [Dictionary<Int, [Item]>.Element] = []
  
  var listsCount: Int {
    return itemsList.count
  }
    
  var fetchItemsFailedListener: ((Bool) -> Void)?
  
  var fetchItemsFailed: Bool = false {
    didSet {
      fetchItemsFailedListener?(fetchItemsFailed)
    }
  }
  
  func fetchItems() async {
    do {
      let itemsFromServer = try await APIService.sendRequest(api: FetchAPI.hiring, decode: [Item].self)
      itemsList = createItemsList(itemsFromServer)
      fetchItemsFailed = false
    } catch {
      Self.logger.error("Failed to download items from server. Error: \(String(describing: error))")
      fetchItemsFailed = true
    }
  }
  
  private func createItemsList(_ items: [Item]) -> [Dictionary<Int, [Item]>.Element] {
    var groupedItemsDictionary: [Int: [Item]] = [:]

    for item in items {
      
      // Excluding Items with null or empty names.
      guard let name = item.name, !name.isEmpty else {
        continue
      }
      
      if groupedItemsDictionary[item.listId] == nil {
        groupedItemsDictionary[item.listId] = [item]
      } else {
        groupedItemsDictionary[item.listId]?.append(item)
      }
    }
    
    // Sort keys and sort values by name
    let sortedItems = groupedItemsDictionary.mapValues({ $0.sorted(by: { $0.itemNameNumber! < $1.itemNameNumber! }) }).sorted(by: { $0.key < $1.key })
    
    return sortedItems
  }
  
  func numberOfItemsInListAtIndex(_ index: Int) -> Int {
    return itemsList[index].value.count
  }
  
  func listAtIndex(_ list: Int) -> Int {
    return itemsList[list].key
  }
  
  func itemAtIndexPath(_ list: Int, row: Int) -> String? {
    return itemsList[list].value[row].name
  }
}

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
  
  /// The original list of items downloaded from the server.
  private var itemsList: [Dictionary<Int, [Item]>.Element] = [] {
    didSet {
      flattenedItems = itemsList.flatMap({ $0.value })
      filteredItems = flattenedItems
    }
  }
  
  /// All items from the server.
  private var flattenedItems: [Item] = []
  
  /// The items used for displaying search results.
  private var filteredItems: [Item] = []
  
  var filteredItemsCount: Int {
    return filteredItems.count
  }
  
  var itemListsCount: Int {
    return itemsList.count
  }
  
  /// Tells the view that fetching items failed or not.
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
  
  /// Processes an array of items. Sorts the final structure of items by
  /// listId and then by name. Will discard any items that have
  /// null or empty names.
  private func createItemsList(_ items: [Item]) -> [Dictionary<Int, [Item]>.Element] {
    var groupedItemsDictionary: [Int: [Item]] = [:]

    for item in items {
      
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
    let sortedItems = groupedItemsDictionary.mapValues({ $0.sorted(by: { ($0.itemNameNumber) < ($1.itemNameNumber) }) }).sorted(by: { $0.key < $1.key })
    
    return sortedItems
  }
  
  func numberOfItemsInListAtIndex(_ index: Int) -> Int {
    return itemsList[index].value.count
  }
  
  func listNameAtIndex(_ list: Int) -> String {
    let listId = itemsList[list].key
    return "List \(listId)"
  }
  
  func listIdAtIndex(_ list: Int) -> Int {
    return itemsList[list].key
  }
  
  func itemAtIndexPath(_ list: Int, row: Int) -> String? {
    return itemsList[list].value[row].name
  }
  
  func filteredItemAtIndex(_ row: Int) -> String? {
    return filteredItems[row].name
  }
  
  func setFilteredItemsListWithSearchText(_ searchText: String) {
    guard let itemNumberFromSearchText = Int(searchText) else { return }
    guard !searchText.isEmpty else {
      filteredItems = flattenedItems
      return
    }
    
    filteredItems = flattenedItems.filter({ $0.itemNameNumber == itemNumberFromSearchText })
  }
}

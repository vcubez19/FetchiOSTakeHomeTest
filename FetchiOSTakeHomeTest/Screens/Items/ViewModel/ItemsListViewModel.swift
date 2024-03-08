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
  
  /// The organized list of items downloaded from the server.
  private var itemsList: [Dictionary<Int, [Item]>.Element] = []
  
  private var allItems: [Item] = []
  
  /// The items used for displaying search results.
  private var filteredItems: [Item] = []
  
  private var searchText: String = "" {
    didSet {
      setFilteredItemsListWithSearchText(searchText)
      noSearchResultsListener?(!searchText.isEmpty && filteredItems.isEmpty)
    }
  }
  
  /// Tells the search results view that no items were found
  /// when searching.
  var noSearchResultsListener: ((Bool) -> Void)?
  
  var filteredItemsCount: Int {
    return filteredItems.count
  }
  
  var itemListsCount: Int {
    return itemsList.count
  }
  
  /// Tells the view that fetching items failed or succeeded.
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
      allItems = itemsFromServer
      filteredItems = itemsFromServer
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
  
  func listLocationForItem(_ item: Item) -> String? {
    return "In list \(item.listId)"
  }
  
  func itemAtIndexPath(_ list: Int, row: Int) -> Item {
    return itemsList[list].value[row]
  }
  
  func filteredItemAtIndex(_ row: Int) -> Item {
    return filteredItems[row]
  }
  
  /// Sets filtered items to items filtered by itemNameNumber
  func setFilteredItemsListWithSearchText(_ searchText: String) {
    guard !searchText.isEmpty else { return }
    
    // Force unwrap is ok because keyboard is the number pad.
    let itemNumberFromSearchText = Int(searchText)!
    
    filteredItems = allItems.filter({ $0.itemNameNumber == itemNumberFromSearchText })
  }
  
  func getSearchBarText() -> String {
    return searchText
  }
  
  func setSearchBarText(_ searchBarText: String) {
    searchText = searchBarText
  }
}

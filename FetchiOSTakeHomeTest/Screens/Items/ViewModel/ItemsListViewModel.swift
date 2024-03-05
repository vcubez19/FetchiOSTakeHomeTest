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
  
  private var items: [Item] = []
  
  var itemsCount: Int {
    return items.count
  }
  
  var fetchItemsFailed: Bool = false
  
  func fetchItems() async {
    do {
      let itemsFromServer = try await APIService.sendRequest(api: FetchAPI.hiring, decode: [Item].self)
      items = itemsFromServer
      fetchItemsFailed = false
    } catch {
      Self.logger.error("Failed to download items from server. Error: \(String(describing: error))")
      fetchItemsFailed = true
    }
  }
}

//
//  Item.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import Foundation

struct Item: Decodable {
  let id, listId: Int
  let name: String?
}

extension Item {
  
  /// Locates and returns an integer from an Item's name property. Will return -1
  /// if there is not an Item name or an integer inside the Item name.
  
  var itemNameNumber: Int {
    guard let name = name else { return -1 }
    return Int(name.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? -1
  }
  
}

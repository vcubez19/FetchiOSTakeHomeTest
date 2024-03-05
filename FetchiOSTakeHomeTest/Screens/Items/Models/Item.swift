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
  
  /// Locates and returns an integer from an Item's name property.
  
  var itemNameNumber: Int? {
    guard let name = name else { return nil }
    return Int(name.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
  }
  
}

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

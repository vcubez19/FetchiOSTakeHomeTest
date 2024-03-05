//
//  API.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import Foundation

protocol API {
  /// .http or .https
  var scheme: HTTPScheme { get }
  
  // Example: "fetch-hiring.s3.amazonaws.com"
  var baseURL: String { get }
  
  // "/hiring.json"
  var path: String { get }
  
  // [URLQueryItem(name: "limit", value: 50)]
  var parameters: [URLQueryItem]? { get }
  
  // "GET"
  var method: HTTPMethod { get }
}

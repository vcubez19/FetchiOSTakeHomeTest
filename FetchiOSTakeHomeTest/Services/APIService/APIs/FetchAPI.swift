//
//  FetchHiringAPI.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import Foundation

enum FetchAPI: API {
  
  case hiring

  var scheme: HTTPScheme {
    switch self {
      case .hiring:
        return .https
    }
  }
  
  var baseURL: String {
    switch self {
      case .hiring:
        return "fetch-hiring.s3.amazonaws.com"
    }
  }
  
  var path: String {
    switch self {
      case .hiring:
        return "/hiring.json"
    }
  }
  
  var parameters: [URLQueryItem]? {
    switch self {
      case .hiring:
        return nil
    }
  }
  
  var method: HTTPMethod {
    switch self {
      case .hiring:
        return .get
    }
  }
}

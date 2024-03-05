//
//  APIService.swift
//  FetchiOSTakeHomeTest
//
//  Created by Vincent Cubit on 3/4/24.
//

import Foundation

struct APIService {
  static func buildURL(endpoint: API) -> URLComponents {
    var components = URLComponents()
    components.scheme = endpoint.scheme.rawValue
    components.host = endpoint.baseURL
    components.path = endpoint.path
    components.queryItems = endpoint.parameters
    
    return components
  }
  
  static func sendRequest<T: Decodable>(api: API, decode: T.Type) async throws -> T {
    guard let url = buildURL(endpoint: api).url else {
      throw APIError.invalidURL
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = api.method.rawValue
    
    do {
      let (data, _) = try await URLSession.shared.data(for: urlRequest)
      return try JSONDecoder().decode(decode.self, from: data)
    } catch {
      throw error
    }
  }
}

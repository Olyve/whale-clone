//
//  APIService.swift
//  whale-clone
//
//  Created by Sam Galizia on 9/13/17.
//  Copyright © 2017 Sam Galizia. All rights reserved.
//

import Moya

enum APIService {
  case loginUser(username: String, password: String)
}

// MARK: - TargetType
extension APIService: TargetType {
  
  var baseURL: URL { return URL(string: "https://whale2-elixir.herokuapp.com/api/v1")! }
  
  var path: String {
    switch self {
    case .loginUser(_,_):
      return "/sessions"
    }
  }
  
  var method: Method {
    switch self {
    case .loginUser(_,_):
      return .post
    }
  }
  
  var headers: [String : String]? {
    switch self {
    default:
      return nil
    }
  }
  
  var task: Task {
    switch self {
    case let .loginUser(email, password):
      return .requestParameters(parameters: ["email": email, "password": password], encoding: URLEncoding.queryString)
    }
  }
  
  var sampleData: Data {
    switch self {
    case let .loginUser(email, password):
      return "{\"email\": \(email), \"password\": \(password)}".utf8Encoded
    }
  }
}

// MARK: - String Utility
private extension String {
  var utf8Encoded: Data {
    return data(using: .utf8)!
  }
}

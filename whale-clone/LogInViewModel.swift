//
//  LogInViewModel.swift
//  whale-clone
//
//  Created by Sam Galizia on 9/13/17.
//  Copyright © 2017 Sam Galizia. All rights reserved.
//

import Bond
import Moya

protocol LogInViewModelType {
  var userIsAuthenticated: Observable<Bool> { get }
  
  func logInUser(email: String, password: String)
}

class LogInViewModel: LogInViewModelType {
  var userIsAuthenticated = Observable<Bool>(false)
  
  fileprivate let apiProvider = MoyaProvider<APIService>()
  
  func logInUser(email: String, password: String) {
    apiProvider.request(.loginUser(username: email, password: password)) { result in
      switch result {
      case let .success(moyaResponse):
        if moyaResponse.statusCode == 200 {
          self.userIsAuthenticated.value = true
        }
        else if 400 ... 499 ~= moyaResponse.statusCode {
          print("ERROR: \(moyaResponse.statusCode) Bad Request")
        }
      case let .failure(error):
        print(error.errorDescription ?? "Unkown error has occured!")
      }
    }
  }
}

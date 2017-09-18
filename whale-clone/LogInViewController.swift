//
//  LogInViewController.swift
//  whale-clone
//
//  Created by Sam Galizia on 9/13/17.
//  Copyright © 2017 Sam Galizia. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var logInButton: UIButton!
  
  fileprivate var viewModel: LogInViewModelType = LogInViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.userIsAuthenticated.observeNext { isAuthenticated in
      if isAuthenticated {
        // TODO: Figure out where the best place to place to put this is
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = MainViewController()
      }
    }.dispose(in: bag)
  }
  
  // Override dismisses keyboard on tap
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  @IBAction func logInTapped(_ sender: UIButton) {
    guard let email = email.text,
          let password = password.text
      else { return }
    
    view.endEditing(true)
    logInButton.isEnabled = false
    
    viewModel.logInUser(email: email, password: password)
  }
  
  @IBAction func signUpTapped(_ sender: UIButton) {
    // TODO: This probably does not belong here. Fix this.
    let signUp = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
    navigationController?.pushViewController(signUp, animated: true)
  }
}

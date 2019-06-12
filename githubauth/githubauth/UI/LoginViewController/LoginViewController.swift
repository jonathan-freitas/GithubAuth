//
//  LoginViewController.swift
//  githubauth
//
//  Created by vuziq on 11/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import UIKit
import GithubAPI
import MaterialComponents.MaterialDialogs

class LoginViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    // Loading Indicator
    let loadingIndicator = LoadingIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfigs()
    }
    
    /// Method responsible for setting up the initial configurations
    private func initialConfigs() {
        
        // Gesture for the Text Fields
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(gesture)
        
        // Delegates
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
        
        // Button
        loginBtn.layer.cornerRadius = 15
        loginBtn.layer.masksToBounds = true
        loginBtn.addTarget(self, action: #selector(loginAction(_:)), for: UIControl.Event.touchUpInside)

    }
    
    /// Function responsible for checking everything before sending to login().
    @IBAction func loginAction(_ sender: Any) {
        if let userText = usernameTxtField.text, let passText = passwordTxtField.text {
            if userText.trimmingCharacters(in: .whitespaces) == "" || passText.trimmingCharacters(in: .whitespaces) == "" {
                showErrorMessage(error: Constants.ErrorObjects.EmptyFields)
            } else {
                login(username: userText, password: passText)
            }
        }
    }
    
    /// Function responsible to login.
    private func login(username: String, password: String) {
        
        // Setting the loading indicator, only to finish after everything is done
        loadingIndicator.startActivityIndicator(view: self.view)
        
        // Basic Authentication (username & password)
        let authentication = BasicAuthentication(username: username, password: password)
        
        // Getting the user
        UserAPI(authentication: authentication).getUser { (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.loadingIndicator.stopActivityIndicator()
                    self.showErrorMessage(error: error as NSError)
                } else if let user = response?.toUser() {
                    self.loadingIndicator.stopActivityIndicator()
                    print(user)
                } else {
                    self.loadingIndicator.stopActivityIndicator()
                    self.showErrorMessage(error: Constants.ErrorObjects.WrongCredentials)
                }
            }
        }
    }
}

extension LoginViewController {
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
}

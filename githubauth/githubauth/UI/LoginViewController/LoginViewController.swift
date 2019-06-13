//
//  LoginViewController.swift
//  githubauth
//
//  Created by vuziq on 11/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import UIKit
import GithubAPI
import IQKeyboardManagerSwift
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
        self.initialConfigs()
        self.checkLoggedUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = true
        
        // Cleaning fields
        usernameTxtField.text = ""
        passwordTxtField.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = false
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
    
    /// Method responsible to check if there's a user logged in.
    private func checkLoggedUser() {
        let savedUser = LoginViewModel.getUser()
        if let user = savedUser {
            Navigation.pushProfileView(viewController: self, user: user)
        } else {
            print("No logged in user found.")
        }
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
    
    /// Method responsible to enable or disable the secure text.
    @IBAction func showPassword(_ sender: UIButton) {
        passwordTxtField.isSecureTextEntry = !passwordTxtField.isSecureTextEntry
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
                    
                    // Saving the user locally & Pushing to ProfielView
                    let savedUser = LoginViewModel.saveUser(user)
                    if let savedUser = savedUser {
                        Navigation.pushProfileView(viewController: self, user: savedUser)
                    }
                    
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

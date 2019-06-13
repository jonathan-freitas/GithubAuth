//
//  UIViewController+Extension.swift
//  githubauth
//
//  Created by Jonathan Freitas on 12/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs

extension UIViewController {
    func showErrorMessage(error: NSError) {
        var message = ""
        
        switch error.code {
        case -1007:
            message = Constants.ErrorMessages.WrongCredentials
            break
        case -1008:
            message = Constants.ErrorMessages.EmptyFields
            break
        case -1009:
            message = Constants.ErrorMessages.InternetError
            break
        default:
            message = Constants.ErrorMessages.UnknownError
            break
        }
        
        Dialog.showSingleActionDialog(viewController: self,
                                      title: "Error",
                                      message: message,
                                      action: MDCAlertAction(title: "Ok", handler: nil))
    }
}

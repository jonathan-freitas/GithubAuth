//
//  Constants.swift
//  githubauth
//
//  Created by Jonathan Freitas on 12/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import Foundation

struct Constants {
    
    /// Image names.
    struct Images {
        static let AvatarPlaceholder = "avatar-placeholder"
    }
    
    /// Error messages.
    struct ErrorMessages {
        static let EmptyFields       = "Both fields must not be empty."
        static let WrongCredentials  = "Wrong username or password."
        static let UnknownError      = "Sorry. An unkown error has ocurred, please try again later."
        static let InternetError     = "It seems you are offline. Please try again later with a better connection."
    }
    
    /// Error objects at view-level.
    struct ErrorObjects {
        static let EmptyFields       = NSError(domain: "self", code: -1008, userInfo: nil)
        static let WrongCredentials  = NSError(domain: "self", code: -1007, userInfo: nil)
    }
}

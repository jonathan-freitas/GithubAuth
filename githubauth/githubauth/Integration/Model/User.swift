//
//  User.swift
//  githubauth
//
//  Created by Jonathan Freitas on 12/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import Foundation
import GithubAPI

struct User {
    
    // MARK: - Properties
    var name: String?
    var username: String?
    var bio: String?
    var avatarUrl: String?
    var location: String?
    var email: String?
    
}

extension UserResponse {
    /// Method responsible for trimming down the UserResponse object.
    func toUser() -> User? {
        if self.login == nil { // Wrong credentials
            return nil
        } else {
            return User(name: self.name, username: self.login, bio: self.bio, avatarUrl: self.avatarUrl, location: self.location, email: self.email)
        }
    }
}
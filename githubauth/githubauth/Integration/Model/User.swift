//
//  User.swift
//  githubauth
//
//  Created by Jonathan Freitas on 12/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import Foundation
import GithubAPI

struct User: Equatable {
    
    // MARK: - Properties
    var name: String?
    var username: String?
    var bio: String?
    var avatarUrl: String?
    var location: String?
    var email: String?
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.username == rhs.username
    }
    
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

extension User {
    /// Method responsible for mapping this user to the realm model.
    func toUserRealm() -> UserRealm {
        return UserRealm(name: self.name ?? "Name not provided.",
                         username: self.username ?? "Username not provided.",
                         bio: self.bio ?? "Bio not provided.",
                         avatarUrl: self.avatarUrl ?? "",
                         location: self.location ?? "Location not provided.",
                         email: self.email ?? "Email not provided.")
    }
}

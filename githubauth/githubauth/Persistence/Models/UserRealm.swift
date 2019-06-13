//
//  UserRealm.swift
//  githubauth
//
//  Created by Jonathan Freitas on 13/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import Foundation
import RealmSwift

class UserRealm: Object {
    
    // MARK: - Properties
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var bio: String = ""
    @objc dynamic var avatarUrl: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var email: String = ""
    
    override class func primaryKey() -> String? {
        return "username"
    }
    
    //Init Properties
    convenience init(name: String, username: String, bio: String, avatarUrl: String, location: String, email: String) {
        self.init()
        self.name = name
        self.username = username
        self.bio = bio
        self.avatarUrl = avatarUrl
        self.location = location
        self.email = email
    }
    
}

extension UserRealm {
    /// Method responsible for mapping this user realm to the view-level user.
    func toUser() -> User {
        return User(name: self.name,
                    username: self.username,
                    bio: self.bio,
                    avatarUrl: self.avatarUrl,
                    location: self.location,
                    email: self.email)
    }
}

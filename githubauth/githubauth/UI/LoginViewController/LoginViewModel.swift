//
//  LoginViewModel.swift
//  githubauth
//
//  Created by Jonathan Freitas on 12/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import Foundation
import GithubAPI

struct LoginViewModel {
    
    static let userPersistenceWorker: UserPersistenceContract = UserPersistenceWorker()
    
    static func saveUser(_ user: User) -> User? {
        return userPersistenceWorker.saveUser(user: user.toUserRealm())?.toUser()
    }
    
    static func getUser() -> User? {
        return userPersistenceWorker.getUser()?.toUser()
    }
    
    static func deleteUser() -> Bool {
        return userPersistenceWorker.deleteUser()
    }
}

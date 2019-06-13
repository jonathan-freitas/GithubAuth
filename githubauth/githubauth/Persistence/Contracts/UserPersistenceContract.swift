//
//  UserPersistenceWorker.swift
//  githubauth
//
//  Created by Jonathan Freitas on 13/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import Foundation

protocol UserPersistenceContract {
    func saveUser(user: UserRealm) -> UserRealm?
    func getUser() -> UserRealm?
    func deleteUser() -> Bool
}

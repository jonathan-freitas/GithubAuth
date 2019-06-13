//
//  UserPersistenceWorker.swift
//  githubauth
//
//  Created by Jonathan Freitas on 13/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import Foundation
import RealmSwift

class UserPersistenceWorker: UserPersistenceContract {
    
    public init() {}
    
    func saveUser(user: UserRealm) -> UserRealm? {
        try? ConnectionRealm.realm.write {
            ConnectionRealm.realm.add(user, update: .all)
        }
        return getUser()
    }
    
    func getUser() -> UserRealm? {
        return ConnectionRealm.realm.objects(UserRealm.self).first
    }
    
    func deleteUser() -> Bool {
        do {
            try ConnectionRealm.realm.write({
                let result = ConnectionRealm.realm.objects(UserRealm.self)
                ConnectionRealm.realm.delete(result)
            })
        } catch let error {
            print(error.localizedDescription)
        }
        return getUser() != nil ? true : false
    }
    
}

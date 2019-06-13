//
//  ConnectionRealm.swift
//  githubauth
//
//  Created by Jonathan Freitas on 13/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import Foundation
import RealmSwift

struct ConnectionRealm {
    
    static let config = Realm.Configuration(schemaVersion: 1)
    
    static var realm = try! Realm(configuration: config)
    
    static func saveRealm(_ object: AnyObject, update: Realm.UpdatePolicy = .all) {
        try! realm.write {
            realm.add(object as! Object, update: update)
        }
    }
    
    static func saveRealmArray(_ objects: [AnyObject], update: Realm.UpdatePolicy = .all) {
        try! realm.write {
            realm.add(objects as! [Object], update: update)
        }
    }
    
    static func deleteRealm(_ object: AnyObject) {
        try! realm.write {
            realm.delete(object as! Object)
        }
    }
    
    static func queriesRealm<T: NSObject>(_ object: AnyObject, filter: String = "id > 0", sorted: String = "id", ascending: Bool = true) -> T{
        let objectRealm = Array(realm.objects(object as! Object.Type).filter(filter).sorted(byKeyPath: sorted, ascending: ascending))
        return objectRealm as! T
    }
}

//
//  DBManager.swift
//  Lesson26
//
//  Created by Владислав Пуцыкович on 27.01.22.
//

import Foundation
import RealmSwift

protocol DBManager {
    func save<T: Object>(object: T)
    func removeObject<T: Object>(object: T)
    func obtainUsers<T: Object>() -> [T]
    func clearAll()
}

class DBManagerImpl: DBManager {
    
    fileprivate lazy var realm = try! Realm(
        configuration: .defaultConfiguration,
        queue: .none
    )
    
    func save<T: Object>(object: T) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func removeObject<T: Object>(object: T) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func clearAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func obtainUsers<T: Object>() -> [T] {
        let models = realm.objects(T.self)
        return Array(models)
    }
}

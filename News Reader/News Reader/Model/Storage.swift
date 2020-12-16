//
//  Storage.swift
//  News Reader
//
//  Created by MAC on 15.12.2020.
//

import Foundation

struct Storage {
    
    let defaults = UserDefaults.standard
    
    var favorites: [Source] {
        get {
            let items = defaults.array(forKey: "favoritesList") as? [Source]
            return items ?? []
        }
        set {
            defaults.set(newValue, forKey: "favoritesList")
        }
    }
    static var storage = Storage()
}

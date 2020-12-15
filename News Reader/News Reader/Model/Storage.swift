//
//  Storage.swift
//  News Reader
//
//  Created by MAC on 15.12.2020.
//

import Foundation

struct Storage {
    
    let defaults = UserDefaults.standard
    
    var favorites: [Source]? {
        get {
            guard let items = defaults.array(forKey: "favoritesList") as? [Source] else { return nil }
            return items
        }
        set {
            defaults.set(newValue, forKey: "favoritesList")
        }
        
    }
    
    static var storage = Storage()
    
}

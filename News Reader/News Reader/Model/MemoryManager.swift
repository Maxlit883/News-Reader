//
//  Storage.swift
//  News Reader
//
//  Created by MAC on 15.12.2020.
//

import Foundation

struct MemoryManager {
    
    let defaults = UserDefaults.standard
    
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    
    static var storage = MemoryManager()
    
    private var favorites: [Source] {
        get {
            guard let data = defaults.data(forKey: "favoritesList") else { return [] }
            return (try? decoder.decode([Source].self, from: data)) ?? []
        }
        set {
            let value: [Source] = Array(Set(newValue))
            guard let data = try? encoder.encode(value) else { return }
            defaults.set(data, forKey: "favoritesList")
        }
    }
    
    private var newsOffline: [Article] {
        get {
            guard let data = defaults.data(forKey: "newsOffline") else { return [] }
            return (try? decoder.decode([Article].self, from: data)) ?? []
        }
        set {
            let value: [Article] = Array(Set(newValue))
            guard let data = try? encoder.encode(value) else { return }
            defaults.set(data, forKey: "newsOffline")
        }
    }
    
// MARK: -- Methods for working with favorites
    
    func getFavorites()-> [Source] {
        return favorites
    }
    
    mutating func addToFavorites(item: Source) {
        favorites.append(item)
    }
    
    mutating func removeFromFavorites(index: Int) {
        favorites.remove(at: index)
    }
    
    
    
// MARK: -- Methods for working with news
    
    func getNews()-> [Article] {
        return newsOffline
    }
    
    mutating func saveNews(items: [Article]) {
        newsOffline = items
    }
    
    mutating func removeNews() {
        newsOffline.removeAll()
    }
    
}

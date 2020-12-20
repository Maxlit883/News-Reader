//
//  Source.swift
//  News Reader
//
//  Created by MAC on 20.12.2020.
//

import Foundation

struct Source: Codable, Hashable {
    let id, name, description: String
    let url: String
    let language, country: String
    
    static func == (lhs: Source, rhs: Source) -> Bool {
        lhs.id == rhs.id
    }
}

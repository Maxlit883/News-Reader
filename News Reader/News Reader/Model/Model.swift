//
//  Model.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import Foundation

// MARK: - Main
struct Chanels: Codable {
    let status: String
    let sources: [Source]
}

// MARK: - Source
struct Source: Codable {
    let id, name, sourceDescription: String
    let url: String
    let language, country: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, language, country
    }
}

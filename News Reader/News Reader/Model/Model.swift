//
//  Model.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import Foundation

// MARK: - Main
struct ChanelData: Codable {
    let sources: [Source]
}

// MARK: - Source
struct Source: Codable, Hashable {
    let id, name, description: String
    let url: String
    let language, country: String
    
    static func == (lhs: Source, rhs: Source) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - News
struct NewsData: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Hashable {
    let title, description: String
    let urlToImage: String?
}



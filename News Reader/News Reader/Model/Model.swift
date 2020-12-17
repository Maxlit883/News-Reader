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
    let id, name, sourceDescription: String
    let url: String
    let language, country: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, language, country
    }
}

// MARK: - News
struct NewsData: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Hashable {
    let title, description: String
    let url: String
    let urlToImage: String
    let publishedAt, content: String

}



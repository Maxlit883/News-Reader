//
//  Article.swift
//  News Reader
//
//  Created by MAC on 20.12.2020.
//

import Foundation

struct Article: Codable, Hashable {
    
    let title, description: String
    let urlToImage: String?

}

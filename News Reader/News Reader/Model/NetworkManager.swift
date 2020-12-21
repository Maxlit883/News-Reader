//
//  NetworkManager.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import Foundation

final class NetworkManager {
    
// MARK: - Private Properties
    
    private let baseURL = "https://newsapi.org/v2/"
    private let requestForSources = "sources?language=en"
    private let requestForNews = "top-headlines?sources="
    private let requestForSearch = "everything?q="
    private let apiKey = "&apiKey=79a70e99060a4e70ad6bdec2305e0aa4"
    
// MARK: - Public Methods
    
    func fetchDataResources(completion: @escaping (Result<[Source], Error>)->()) {
        
        let decoder = JSONDecoder()
       
        let urlStr = baseURL + requestForSources + apiKey
        guard let url = URL(string: urlStr) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) {  data, _, error in
            
            OperationQueue.main.addOperation {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let decodedData = try decoder.decode(ChanelData.self, from: data)
                        completion(.success(decodedData.sources))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
    
    func fetchDataNews(favorites: [Source], completion: @escaping ([Article])->()) {
        
        let decoder = JSONDecoder()
        let favoritesID = favorites.map { $0.id }
        var newsList: [Article] = []
        
        let group = DispatchGroup()
        
        for id in favoritesID {
            group.enter()
            
            let urlStr = baseURL + requestForNews + id + apiKey
            guard let url = URL(string: urlStr) else { return }
            
            let session = URLSession.shared
            session.dataTask(with: url) {  data, _, error in
                defer {
                    group.leave()
                }
                if let data = data {
                    do {
                        let decodedData = try decoder.decode(NewsData.self, from: data)
                        newsList.append(contentsOf: decodedData.articles)
                    } catch {
                        print("Catch in fetch \(error)")
                    }
                }
            }.resume()
        }
        group.notify(queue: .main) {
            completion(newsList)
        }
    }
    
    func fetchNewsByKeywords(keyword: String, completion: @escaping (Result<[Article], Error>)->()) {
        let decoder = JSONDecoder()
        
        let urlStr = baseURL + requestForSearch + keyword + apiKey
        
        guard let encodedKeyword = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
              let url = URL(string: encodedKeyword) else { return }

        let session = URLSession.shared
        session.dataTask(with: url) {  data, _, error in
            
            OperationQueue.main.addOperation {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let decodedData = try decoder.decode(NewsData.self, from: data)
                        completion(.success(decodedData.articles))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
    
}


//
//  NetworkManager.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import Foundation

final class NetworkManager {
    
    private let baseURL = "https://newsapi.org/v2/"
    private let requestForSources = "sources?language=ru"
    private let requestForNews = "top-headlines?sources="
    private let apiKey = "&apiKey=ca2bd634332f4932b0d2604c6514d176"
    
    func fetchDataResources(completion: @escaping (Result<[Source], Error>)->()) {
        
        let urlStr = baseURL + requestForSources + apiKey
        
        guard let url = URL(string: urlStr) else { return }
        
        let decoder = JSONDecoder()
        
        let session = URLSession.shared
        session.dataTask(with: url) {  data, response, error in
            
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
    
    func fetchDataNews(source: [Source], completion: @escaping (Result<[Article], Error>)->()) {
        
        for s in source {
            
            let urlStr = baseURL + requestForNews + s.id + apiKey
            
            guard let url = URL(string: urlStr) else { return }
            
            let decoder = JSONDecoder()
            
            let session = URLSession.shared
            session.dataTask(with: url) {  data, response, error in
                
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
    
}


//
//  NetworkManager.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import Foundation

final class NetworkManager {
    
    enum Lang: String {
        case ru
        case en
    }
    
// MARK: - Private Properties
    
    private let baseURL = "https://newsapi.org/v2/"
    private let requestForSources = "sources?language="
    private let requestForNews = "top-headlines?sources="
    private let requestForSearch = "everything?q="
    private let apiKey = "&apiKey=79a70e99060a4e70ad6bdec2305e0aa4"
    
    
    
// MARK: - Public Methods

    func fetchDataResources(language: Lang, completion: @escaping (Result<ChanelData, Error>)->()) {
        
        let urlStr = baseURL + requestForSources + language.rawValue + apiKey
        
        guard let url = URL(string: urlStr) else { return }
        
        createDataTask(url: url, onComplete: completion)
    }
    
    func fetchDataNews(favorites: [Source], completion: @escaping ([Article])->()) {
        let favoritesID = favorites.map { $0.id }
        var newsList: [Article] = []
        let group = DispatchGroup()
        
        for id in favoritesID {
            group.enter()
            
            let urlStr = baseURL + requestForNews + id + apiKey
            guard let url = URL(string: urlStr) else { return }
            
            createDataTask(url: url) { (result: Result<NewsData, Error>) in
                defer { group.leave() }
                
                switch result {
                case .failure(let error):
                    print(#function, error.localizedDescription)
                    
                case .success(let object):
                    newsList.append(contentsOf: object.articles)
                }
            }
        }
        group.notify(queue: .main) {
            completion(newsList)
        }
    }
    
    func fetchNewsByKeywords(keyword: String, completion: @escaping (Result<NewsData, Error>)->()) {
        let urlStr = baseURL + requestForSearch + keyword + apiKey
        
        guard let encodedKeyword = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
              let url = URL(string: encodedKeyword) else { return }

        createDataTask(url: url, onComplete: completion)
    }
}

private extension NetworkManager {
    
    func createDataTask<T: Decodable>(url: URL, onComplete: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            OperationQueue.main.addOperation {
                if let error = error {
                    onComplete(.failure(error))
                } else if let data = data {
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        
                        onComplete(.success(object))
                    } catch {
                        onComplete(.failure(error))
                    }
                } else {
                    onComplete(.failure(ApiError.emptyResponse))
                }
            }
        }.resume()
    }
}

enum ApiError: LocalizedError {
    case emptyResponse
    
    var errorDescription: String? {
        switch self {
        case .emptyResponse:
            return "Response is empty"
        }
    }
}





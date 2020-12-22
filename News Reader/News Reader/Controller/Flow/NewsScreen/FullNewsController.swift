//
//  FullNewsController.swift
//  News Reader
//
//  Created by MAC on 17.12.2020.
//

import UIKit

final class FullNewsController: UITableViewController {
    
    // MARK: - Private Properties
    
    private var newsList: [Article] = CacheManager.shared.getNews()
    private var favoritesList: [Source] = CacheManager.shared.getFavorites()
    private let networkManager = NetworkManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FullNewsXibCell", bundle: nil), forCellReuseIdentifier: "FullNewsXibCell")
        
        fetchData()
    }
    
    // MARK: - Private Methods
    
    private func fetchData() {
        networkManager.fetchDataNews(favorites: favoritesList) { news in
            self.newsList += news
            CacheManager.shared.saveNews(items: news)
            
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table view data source

extension FullNewsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FullNewsXibCell", for: indexPath) as! FullNewsXibCell
        cell.configCell(by: newsList[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let urlString = newsList[indexPath.row].url
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as? FullNewsXibCell
        cell?.mainImage.cancelPrefetching()
    }
    
}

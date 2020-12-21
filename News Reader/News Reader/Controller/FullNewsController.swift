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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.register(UINib(nibName: "FullNewsXibCell", bundle: nil), forCellReuseIdentifier: "FullNewsXibCell")
        fetchData()
        
    }
    
    // MARK: - Private Methods
    
    private func fetchData() {
        networkManager.fetchDataNews(favorites: favoritesList) { news in
            self.newsList = news
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
        
        let url = newsList[indexPath.row].urlToImage.flatMap { URL(string: $0) }
        cell.mainImage.setImage(from: url, placeholder: UIImage(named: "placeholder"))
        
        cell.bigTitleLabel.text = newsList[indexPath.row].title
        cell.descriptionLabel.text = newsList[indexPath.row].description
        
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

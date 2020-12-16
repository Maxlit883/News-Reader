//
//  NewsController.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class NewsController: UITableViewController {
    
    // MARK: - Properties
    var chanelList: [Source] = []
    let networkManager = NetworkManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    // MARK: - Methods
    
    private func fetchData() {
        networkManager.fetchData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let list):
                self?.chanelList = list
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func addToFavorites(index: Int) {
        Storage.storage.favorites.append(chanelList[index])
    }
    
}

extension NewsController {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chanelList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellIdentifier", for: indexPath) as? NewsCell
        cell?.configCell(by: chanelList[indexPath.row])
        
        cell?.favoritesButton.addTarget(self, action: #selector(addToFavorites(index:)), for: .touchUpInside)
        
        
        return cell!
    }
    
    // MARK: - Table view delegate
    
    
    
    
    
}


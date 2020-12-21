//
//  NewsController.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class SourcesController: UITableViewController {
    
// MARK: - Private Properties
    
    private var chanelList: [Source] = []
    private var favoritesList: [Source] = []
    private let networkManager = NetworkManager()
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favoritesList = CacheManager.shared.getFavorites()
        tableView.reloadData()
    }
    
// MARK: - Private Methods
    
    private func fetchData() {
        networkManager.fetchDataResources { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let list):
                self?.chanelList = list
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - Delegate for adding to favorites

extension SourcesController: CelllDelegateProtocol {
    
    func addToFavorites(index: Int) {
        CacheManager.shared.addToFavorites(item: chanelList[index])
        favoritesList.append(chanelList[index])
        tableView.reloadData()
    }
    
// MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chanelList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let source = chanelList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourcesCellIdentifier", for: indexPath) as! SourcesCell
        cell.configCell(by: source)
        cell.markAsFavorite(favoritesList.contains(source))
        cell.favoritesButton.tag = indexPath.row
        cell.cellDelegate = self
        
        return cell
    }
    
}


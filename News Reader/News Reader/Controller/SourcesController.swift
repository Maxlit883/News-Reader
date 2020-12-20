//
//  NewsController.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class SourcesController: UITableViewController {
    
    // MARK: - Properties
    var chanelList: [Source] = []
    var favoritesList: [Source] = []
    let networkManager = NetworkManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favoritesList = MemoryManager.storage.getFavorites()
        tableView.reloadData()
    }
    
    // MARK: - Methods
    
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

extension SourcesController: CelllDelegateProtocol {
    
    func addToFavorites(index: Int) {
        MemoryManager.storage.addToFavorites(item: chanelList[index])
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
        cell.favoritesContainsSource(source, in: favoritesList)
        cell.favoritesButton.tag = indexPath.row
        cell.cellDelegate = self
        

        
        return cell
    }
    
    // MARK: - Table view delegate
    
    
    
    
    
}


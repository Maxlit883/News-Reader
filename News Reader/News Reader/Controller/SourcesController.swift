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
    let networkManager = NetworkManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()

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
        Storage.storage.addToFavorites(item: chanelList[index])
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chanelList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourcesCellIdentifier", for: indexPath) as? SourcesCell
        cell?.configCell(by: chanelList[indexPath.row])
        cell?.favoritesButton.tag = indexPath.row
        cell?.cellDelegate = self
        
        
        return cell!
    }
    
    // MARK: - Table view delegate
    
    
    
    
    
}


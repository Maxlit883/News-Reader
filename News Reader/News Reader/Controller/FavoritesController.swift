//
//  FavoritesController.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class FavoritesController: UITableViewController {

// MARK: - Private Properties
    
    private var favoritesList: [Source] = []
    private var rows: [Row] = []
    
// MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rows = MemoryManager.storage.getFavorites().map { Row.favoriteItem(source: $0) }
        favoritesList = MemoryManager.storage.getFavorites()
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension FavoritesController {
    
    func removeFromFavorites(index: Int) {
        MemoryManager.storage.removeFromFavorites(index: index)
        
        tableView.beginUpdates()
        
        rows.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .top)
        
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch rows[indexPath.row] {
        case .favoriteItem(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCellIdentifier", for: indexPath) as! FavoritesCell
            cell.configCell(by: item)
            
            cell.onRemove = { [unowned self, item] in

                let itemIndex = self.rows.firstIndex(where: {
                    switch $0 {
                    case .favoriteItem(let source) where source == item:
                        return true
                    default:
                        return false
                    }
                })
                guard let index = itemIndex else { return }
                
                self.removeFromFavorites(index: index)
            }
            return cell
        }
    }
}

extension FavoritesController {
    
    enum Row {
        case favoriteItem(source: Source)
    }
    
}

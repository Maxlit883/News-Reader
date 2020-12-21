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
        configBarItem()
        rows = CacheManager.shared.getFavorites().map { Row.favoriteItem(source: $0) }
        favoritesList = CacheManager.shared.getFavorites()
        tableView.reloadData()
    }
    
// MARK: - Private Methods
    
    private func configBarItem() {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 15)))
        
        button.backgroundColor = .purple
        button.setTitle("SHOW NEWS", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(showNewsAction), for: .touchUpInside)
        
        navigationItem.setRightBarButton(UIBarButtonItem(customView: button), animated: false)
    }
    
    @objc private func showNewsAction() {
        performSegue(withIdentifier: "FavoritesToNews", sender: self)
    }
    
}




// MARK: - Table view data source

extension FavoritesController {
    
    func removeFromFavorites(index: Int) {
        CacheManager.shared.removeFromFavorites(index: index)
        
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

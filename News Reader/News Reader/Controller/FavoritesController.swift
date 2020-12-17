//
//  FavoritesController.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class FavoritesController: UITableViewController {

    var favoritesList: [Source] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesList = Storage.storage.getFavorites()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToNews" {
            let vc = segue.destination as! FullNewsController
            vc.chanelsList = favoritesList
        }
    }
}


// MARK: - Table view data source

extension FavoritesController: RemoveCellProtocol {
    
    func removeFromFavorites(index: Int) {
        Storage.storage.removeFromFavorites(index: index)
        tableView.reloadData()
    }
    
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCellIdentifier", for: indexPath) as? FavoritesCell
        cell?.configCell(by: favoritesList[indexPath.row])
        cell?.removeFromFavoritesButton.tag = indexPath.row
        
        cell?.cellDelegate = self
        
        return cell!
    }
    

}

//
//  FavoritesController.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class FavoritesController: UITableViewController {

    var favoritesList: [Source] = Storage.storage.favorites
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCellIdentifier", for: indexPath) as? FavoritesCell
        cell?.configCell(by: favoritesList[indexPath.row])
        
//        cell?.favoritesButton.addTarget(self, action: #selector(addToFavorites(index:)), for: .touchUpInside)
        
        
        return cell!
    }
    

}

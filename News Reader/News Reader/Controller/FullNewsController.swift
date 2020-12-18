//
//  FullNewsController.swift
//  News Reader
//
//  Created by MAC on 17.12.2020.
//

import UIKit

final class FullNewsController: UITableViewController {

    var newsList: [Article] = []
    var favoritesList: [Source] = Storage.storage.getFavorites()
    let networkManager = NetworkManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func fetchData() {
        networkManager.fetchDataNews(favorites: favoritesList) { news in
            self.newsList = news
            self.tableView.reloadData()
        }
    }
}
    
extension FullNewsController {
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FullNewsIdentifier", for: indexPath) 
        cell.textLabel?.text = newsList[indexPath.row].title

        
        
        return cell
    }


}

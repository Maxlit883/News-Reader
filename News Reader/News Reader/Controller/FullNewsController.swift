//
//  FullNewsController.swift
//  News Reader
//
//  Created by MAC on 17.12.2020.
//

import UIKit

final class FullNewsController: UITableViewController {

    var chanelsList: [Source] = []
    var newsList: [Article] = []
    
    let networkManager = NetworkManager()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    private func fetchData() {
        networkManager.fetchDataNews(source: chanelsList) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let list):
                self?.newsList.append(contentsOf: list)
                self?.tableView.reloadData()
            }
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

//
//  SearchController.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class SearchController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var newsList: [Article] = []
    let networkManager = NetworkManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Methods
    
    
}

// MARK: - Table view data source
extension SearchController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCellIdentifier", for: indexPath) as! SearchCell
        cell.titleLabel.text = newsList[indexPath.row].title
        cell.descriptionLabel.text = newsList[indexPath.row].description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.endEditing(true)
    }
    
    
}

// MARK: - Search bar delegate
extension SearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        
        self.networkManager.fetchNewsByKeywords(keyword: keyword) { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let list):
                self?.newsList = list
                self?.tableView.reloadData()
                self?.searchBar.endEditing(true)
            }
        }
    }
    
}

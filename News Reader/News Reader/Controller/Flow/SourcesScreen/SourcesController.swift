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
    private var language: NetworkManager.Lang = .ru
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        langBarItem()
        configureRefreshControl()
        fetchData(language: language)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favoritesList = CacheManager.shared.getFavorites()
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func fetchData(language: NetworkManager.Lang) {
        
        let activityIndicator = ActivityIndicator.createIndicator(view: view)
        activityIndicator.startAnimating()
        
        networkManager.fetchDataResources(language: language) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let list):
                self?.chanelList = list.sources
                self?.tableView.reloadData()
            }
            activityIndicator.stopAnimating()
        }
    }
    
    private func langBarItem() {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 70, height: 15)))
        
        button.backgroundColor = .purple
        button.setTitle("English", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        
        navigationItem.setRightBarButton(UIBarButtonItem(customView: button), animated: true)
    }
    
    @objc private func changeLanguage() {
        
        switch language {
        case .ru:
            language = .en
            fetchData(language: .en)
            changeTextOnBarItem()
        case .en:
            language = .ru
            fetchData(language: .ru)
            changeTextOnBarItem()
        }
    }
    
    private func changeTextOnBarItem() {
        switch language {
        case .en:
            let item = self.navigationItem.rightBarButtonItem!
            let button = item.customView as! UIButton
            button.setTitle("Русский", for: .normal)
        case .ru:
            let item = self.navigationItem.rightBarButtonItem!
            let button = item.customView as! UIButton
            button.setTitle("English", for: .normal)
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
    
    // MARK: - Refresh control
    
    func configureRefreshControl () {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        fetchData(language: language)
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    
}


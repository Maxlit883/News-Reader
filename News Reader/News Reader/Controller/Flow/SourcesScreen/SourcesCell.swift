//
//  SourcesCell.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class SourcesCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var bigTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    // MARK: - Public Properties
    
    var cellDelegate: CelllDelegateProtocol?
    
    // MARK: - Private Properties
    
    private let highlitedImage = UIImage(named: "icons8-star-1")
    private let usualImage = UIImage(named: "icons8-add_to_favorites")
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bigTitleLabel.text = ""
        descriptionLabel.text = ""
        favoritesButton.setImage(usualImage, for: .normal)
    }
    
    // MARK: - Public Methods
    
    func configCell(by model: Source) {
        bigTitleLabel.text = model.name
        descriptionLabel.text = model.description
    }
    
    func markAsFavorite(_ contains: Bool) {
        if contains {
            self.favoritesButton.setImage(highlitedImage, for: .normal)
        } else {
            self.favoritesButton.setImage(usualImage, for: .normal)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func addToFavoritesButton(sender: UIButton) {
        self.cellDelegate?.addToFavorites(index: sender.tag)
    }
    
}

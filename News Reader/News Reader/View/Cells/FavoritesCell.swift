//
//  FavoritesCell.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class FavoritesCell: UITableViewCell {
    
// MARK: - IBOutlets
    
    @IBOutlet private weak var bigTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var removeFromFavoritesButton: UIButton!
    
// MARK: - Public Properties
 
    var onRemove: (()->())?
    
// MARK: - Private Properties
        
    private let highlitedImage = UIImage(named: "icons8-trash-1")
    
// MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bigTitleLabel.text = ""
        descriptionLabel.text = ""
    }

// MARK: - Public Methods
    
    func configCell(by model: Source) {
        bigTitleLabel.text = model.name
        descriptionLabel.text = model.description
        self.removeFromFavoritesButton.setImage(highlitedImage, for: .highlighted)
    }
    
// MARK: - IBActions
    
    @IBAction func removeButtonPressed(sender: UIButton) {
        onRemove?()
    }

}

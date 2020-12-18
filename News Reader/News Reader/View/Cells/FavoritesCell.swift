//
//  FavoritesCell.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class FavoritesCell: UITableViewCell {

    @IBOutlet private weak var bigTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var removeFromFavoritesButton: UIButton!
        
    let highlitedImage = UIImage(named: "icons8-garbage_truck")

    
    var onRemove: (()->())?
    
    func configCell(by model: Source) {
        bigTitleLabel.text = model.name
        descriptionLabel.text = model.description
        self.removeFromFavoritesButton.setImage(highlitedImage, for: .highlighted)
        
    }
    
    @IBAction func removeButtonPressed(sender: UIButton) {
        onRemove?()
    }

}

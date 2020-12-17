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
        
    var cellDelegate: RemoveCellProtocol?
    
    func configCell(by model: Source) {
        
        bigTitleLabel.text = model.name
        descriptionLabel.text = model.sourceDescription
        
    }
    
    @IBAction func removeButtonPressed(sender: UIButton) {
        cellDelegate?.removeFromFavorites(index: sender.tag)
    }

}

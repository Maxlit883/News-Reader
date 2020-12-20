//
//  SourcesCell.swift
//  News Reader
//
//  Created by MAC on 14.12.2020.
//

import UIKit

final class SourcesCell: UITableViewCell {

    @IBOutlet private weak var bigTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var cellDelegate: CelllDelegateProtocol?
    let highlitedImage = UIImage(named: "icons8-star-1")
    let usualImage = UIImage(named: "icons8-add_to_favorites")
    
    func configCell(by model: Source) {
        bigTitleLabel.text = model.name
        descriptionLabel.text = model.description
    }
    
    func favoritesContainsSource(_ source: Source, in array: [Source]) {
        if array.contains(source) {
            self.favoritesButton.setImage(highlitedImage, for: .normal)
        } else {
            self.favoritesButton.setImage(usualImage, for: .normal)
        }
    }
    
    @IBAction func addToFavoritesButton(sender: UIButton) {
        self.cellDelegate?.addToFavorites(index: sender.tag)
    }

}

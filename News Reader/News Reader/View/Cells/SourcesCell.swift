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
    
    func configCell(by model: Source) {
        bigTitleLabel.text = model.name
        descriptionLabel.text = model.sourceDescription
    }
    
    @IBAction func addToFavoritesButton(sender: UIButton) {
        self.cellDelegate?.addToFavorites(index: sender.tag)
    }

}

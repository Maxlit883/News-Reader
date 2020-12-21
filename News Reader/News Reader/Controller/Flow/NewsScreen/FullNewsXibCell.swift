//
//  FullNewsXibCell.swift
//  News Reader
//
//  Created by MAC on 20.12.2020.
//

import UIKit

final class FullNewsXibCell: UITableViewCell {

// MARK: - Outlets
    
    @IBOutlet weak var mainImage: PrefetchableImageView!
    @IBOutlet weak var bigTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
// MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainImage.image = nil
        bigTitleLabel.text = ""
        descriptionLabel.text = ""
    }
}


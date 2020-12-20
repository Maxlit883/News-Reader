//
//  PrefetchableImageView.swift
//  News Reader
//
//  Created by MAC on 20.12.2020.
//

import UIKit
import Kingfisher

final class PrefetchableImageView: UIImageView {

// MARK: - Private Properties -

    private var token: DownloadTask?
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)

        indicator.color = .darkGray
        indicator.hidesWhenStopped = true

        addSubview(indicator)

        return indicator
    }()

// MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}

// MARK: - Public Methods

extension PrefetchableImageView {
    
    func cancelPrefetching() {
        activityIndicator.stopAnimating()

        token?.cancel()
        token = nil
    }

    func setImage(from url: URL?, placeholder: UIImage? = nil, onImageSet: ((UIImage?) -> Void)? = nil) {
        token?.cancel()

        image = placeholder

        guard let url = url else {
            return
        }

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        token = kf.setImage(with: url, placeholder: placeholder, completionHandler: { [weak self] (result) in
            self?.activityIndicator.stopAnimating()

            switch result {
            case .success(let imageResult):
                onImageSet?(imageResult.image)

            default:
                onImageSet?(nil)
            }
        })
    }
}

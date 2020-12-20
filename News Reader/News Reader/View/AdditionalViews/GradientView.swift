//
//  GradientView.swift
//  News Reader
//
//  Created by MAC on 19.12.2020.
//

import UIKit

final class GradientView: UIView {

// MARK: - Private Properties
    
    lazy private var gradientLayer: CAGradientLayer = {
        
        let color1 = UIColor.clear.cgColor
        let color2 = UIColor.init(white: 0.0, alpha: 0.8).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        return gradientLayer
    }()
    
// MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientLayer.frame = bounds
        backgroundColor = UIColor.clear
        
        layer.addSublayer(gradientLayer)
    }
}

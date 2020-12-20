//
//  GradientView.swift
//  MaxCollectionViewVol2
//
//  Created by Dmitriy Yurchenko on 23.06.2020.
//  Copyright © 2020 Dmitriy Yurchenko. All rights reserved.
//

import UIKit

final class GradientView: UIView {

    lazy var gradientLayer: CAGradientLayer = {
        
        let color1 = UIColor.clear.cgColor
        let color2 = UIColor.init(white: 0.0, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        return gradientLayer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
}

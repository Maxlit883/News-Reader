//
//  ActivityIndicator.swift
//  News Reader
//
//  Created by MAC on 21.12.2020.
//

import UIKit

class ActivityIndicator {
    
    static func createIndicator(view: UIView) -> UIActivityIndicatorView {
    
        var indicator = UIActivityIndicatorView()
        indicator = UIActivityIndicatorView(style: .whiteLarge)
        
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        indicator.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addSubview(indicator)
        
        return indicator
    }
    
}

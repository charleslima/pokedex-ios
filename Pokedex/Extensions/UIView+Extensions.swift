//
//  UIView+Extensions.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import UIKit

extension UIView {
    
    func setShadow(_ color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shouldRasterize = false
        self.clipsToBounds = false
    }
    
    func setGradientBackground(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
}

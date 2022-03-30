//
//  Gradient.swift
//  testtask
//
//  Created by Dmitry on 30.03.22.
//

import UIKit

class GradientView: UIView {
    
    var topColor: UIColor = Constants.Color.redColor
    var bottomColor: UIColor = Constants.Color.purpleColor
    
    var startPointX: CGFloat = 0
    var startPointY: CGFloat = 0
    
    var endPointX: CGFloat = 1
    var endPointY: CGFloat = 1
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

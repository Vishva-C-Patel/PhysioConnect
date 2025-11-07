//
//  GradientView.swift
//  Screen1
//
//  Created by user@9 on 02/11/25.
//

import UIKit

// @IBDesignable
class GradientView: UIView {

    @IBInspectable var startColor: UIColor = UIColor.systemBlue
    @IBInspectable var endColor: UIColor = UIColor.white

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
}


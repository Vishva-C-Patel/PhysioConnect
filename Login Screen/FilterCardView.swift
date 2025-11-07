//
//  FilterCardView.swift
//  PhysioConnect
//
//  Created by user@8 on 06/11/25.
//

import UIKit

class FilterCardView: UIView {

    override func awakeFromNib() {
            super.awakeFromNib()
            layer.cornerRadius = 24
            layer.masksToBounds = true
            backgroundColor = .white
            
            // Optional subtle shadow
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.08
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowRadius = 6
            layer.masksToBounds = false
        }
}

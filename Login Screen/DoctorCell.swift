//
//  DoctorCell.swift
//  PhysioConnect
//
//  Created by user@8 on 05/11/25.
//

import UIKit

class DoctorCell: UITableViewCell {
    
    
    @IBOutlet weak var doctorImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    @IBOutlet weak var specializationLabel: UILabel!
    
    
    @IBOutlet weak var feesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.white
            backgroundColor = .clear

            contentView.layer.cornerRadius = 24
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor(hex: "#D4E3FE").cgColor
            
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.1
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowRadius = 4
            layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        doctorImage.layer.cornerRadius = 24
        doctorImage.clipsToBounds = true
        
        contentView.layer.cornerRadius = 24
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(hex: "#D4E3FE").cgColor
        
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false

        // Configure the view for the selected state
    }
    
    func configure(with doctor: Doctor) {
            doctorImage.image = UIImage(named: doctor.imageName)
            nameLabel.text = doctor.name
            detailsLabel.text = "⭐ \(doctor.rating) | \(doctor.reviews) reviews"
            distanceLabel.text = doctor.distance
            specializationLabel.text = doctor.specialization
            feesLabel.text = doctor.fees
        }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            // Adds top and bottom padding for spacing between cells
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
        }

}


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

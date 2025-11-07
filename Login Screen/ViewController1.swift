//
//  ViewController.swift
//  Screen1
//
//  Created by user@9 on 02/11/25.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet var AppIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppIcon.image = UIImage(systemName: "heart.circle.fill")
        AppIcon.tintColor = .systemBlue
        
    }


}


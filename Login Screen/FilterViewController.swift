//
//  FilterViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 06/11/25.
//

import UIKit

protocol FilterDelegate: AnyObject {
    func didApplyFilters(_ filters: FilterModel)
}

class FilterViewController: UIViewController {
    
    
        @IBOutlet var specialityButtons: [UIButton]!
        @IBOutlet var genderButtons: [UIButton]!
        @IBOutlet weak var distanceSlider: UISlider!
        @IBOutlet weak var distanceLabel: UILabel!
        @IBOutlet var starButtons: [UIButton]!
    
    @IBOutlet weak var contentView: UIView!
    
    weak var delegate: FilterDelegate?
        var filters = FilterModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.95)
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Setup
        private func setupUI() {
            // Deselect all buttons initially
            specialityButtons.forEach { configureButton($0) }
            genderButtons.forEach { configureButton($0) }
            starButtons.forEach { $0.tintColor = .systemGray3 }
            distanceSlider.value = 15
            distanceLabel.text = "within 15 km"
            
            
            contentView.layer.cornerRadius = 24
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            contentView.clipsToBounds = true
        }
    
    
    // MARK: - Overlay Animations
    private func animateIn() {
        // Start with the contentView below the screen
        contentView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseOut,
                       animations: {
                           self.contentView.transform = .identity
                           self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                       },
                       completion: nil)
    }

    private func animateOut(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.25,
                       animations: {
                           self.contentView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
                           self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
                       }) { _ in
            completion?()
        }
    }

        
        private func configureButton(_ button: UIButton) {
            button.setImage(UIImage(systemName: "circle"), for: .normal)
            button.setImage(UIImage(systemName: "circle.fill"), for: .selected)
            button.tintColor = .systemBlue
        }

        // MARK: - Actions
        @IBAction func specialityTapped(_ sender: UIButton) {
            // Deselect all, select one
            specialityButtons.forEach { $0.isSelected = false }
            sender.isSelected = true
            filters.selectedSpeciality = sender.titleLabel?.text
        }

        @IBAction func genderTapped(_ sender: UIButton) {
            genderButtons.forEach { $0.isSelected = false }
            sender.isSelected = true
            filters.selectedGender = sender.titleLabel?.text
        }
        
        @IBAction func distanceSliderChanged(_ sender: UISlider) {
            let value = Int(sender.value)
            filters.selectedDistance = sender.value
            distanceLabel.text = "within \(value) km"
        }

        @IBAction func starTapped(_ sender: UIButton) {
            let rating = sender.tag
            filters.selectedRating = rating
            for btn in starButtons {
                btn.tintColor = btn.tag <= rating ? .systemYellow : .systemGray3
            }
        }

        @IBAction func removeTapped(_ sender: UIButton) {
            // Reset everything visually and in model
            filters = FilterModel()
            specialityButtons.forEach { $0.isSelected = false }
            genderButtons.forEach { $0.isSelected = false }
            starButtons.forEach { $0.tintColor = .systemGray3 }
            distanceSlider.value = 15
            distanceLabel.text = "within 15 km"
        }

        @IBAction func cancelTapped(_ sender: UIButton) {
            animateOut {
                self.dismiss(animated: false)
            }

        }

        @IBAction func applyTapped(_ sender: UIButton) {
            delegate?.didApplyFilters(filters)
            animateOut {
                self.dismiss(animated: false)
            }

        }

}

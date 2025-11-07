//
//  ViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 02/11/25.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    // These are the container views that wrap each text field (icon + text field)
    @IBOutlet weak var nameContainer: UIView!
    @IBOutlet weak var emailContainer: UIView!
    @IBOutlet weak var passwordContainer: UIView!
    @IBOutlet weak var dobContainer: UIView!
    @IBOutlet weak var genderContainer: UIView!
    @IBOutlet weak var phoneContainer: UIView!
    
    // MARK: - Pickers
    private let genders = ["Male", "Female", "Other"]
    private var datePicker: UIDatePicker = UIDatePicker()
    private var genderPicker: UIPickerView = UIPickerView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup all UI components
        setupDatePicker()
        setupGenderPicker()
        configureReturnKeys()
        applyUIStyles()
        
        // Disable keyboard for dropdown fields
        dobField.inputView = UIView()
        genderField.inputView = UIView()
        
        // Dismiss picker when tapping outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissDropdowns))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // Assign delegates
        [nameField, emailField, passwordField, dobField, genderField, phoneField].forEach {
            $0?.delegate = self
        }
    }
    
    // MARK: - Setup Pickers
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        if #available(iOS 14.0, *) { datePicker.preferredDatePickerStyle = .wheels }
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        styleDropdown(datePicker)
        datePicker.isHidden = true
        view.addSubview(datePicker)
    }
    
    private func setupGenderPicker() {
        genderPicker.delegate = self
        genderPicker.dataSource = self
        styleDropdown(genderPicker)
        genderPicker.isHidden = true
        view.addSubview(genderPicker)
    }
    
    // MARK: - Common Dropdown Styling
    private func styleDropdown(_ v: UIView) {
        v.backgroundColor = .systemBackground
        v.layer.cornerRadius = 12
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.15
        v.layer.shadowRadius = 6
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    // MARK: - Dropdown Show/Hide
    private func showDropdown(_ dropdown: UIView, below textField: UITextField, height: CGFloat = 180) {
        hideDropdowns()
        let tfFrame = textField.convert(textField.bounds, to: view)
        dropdown.frame = CGRect(
            x: tfFrame.minX,
            y: tfFrame.maxY + 8,
            width: tfFrame.width,
            height: height
        )
        view.bringSubviewToFront(dropdown)
        dropdown.alpha = 0
        dropdown.isHidden = false
        UIView.animate(withDuration: 0.25) { dropdown.alpha = 1 }
    }
    
    private func hideDropdowns() {
        [datePicker, genderPicker].forEach { dd in
            guard !dd.isHidden else { return }
            UIView.animate(withDuration: 0.2, animations: { dd.alpha = 0 }) { _ in
                dd.isHidden = true
            }
        }
    }
    
    @objc private func dismissDropdowns() {
        hideDropdowns()
        view.endEditing(true)
    }
    
    // MARK: - Date Change
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let f = DateFormatter()
        f.dateFormat = "dd MMM yyyy"
        dobField.text = f.string(from: sender.date)
    }
    
    // MARK: - Keyboard Return Behaviour
    private func configureReturnKeys() {
        nameField.returnKeyType = .next
        emailField.returnKeyType = .next
        passwordField.returnKeyType = .next
        dobField.returnKeyType = .next
        genderField.returnKeyType = .next
        phoneField.returnKeyType = .done
    }
    
    // MARK: - Button Action
    @IBAction func createAccountTapped(_ sender: UIButton) {
        dismissDropdowns()
        print("Create Account tapped")
    }
    
    // MARK: - Apply UI Styles (Borders + Shadows)
    private func applyUIStyles() {
        // Shadow for Google & Apple buttons
        [googleButton, appleButton].forEach {
            $0?.backgroundColor = .white
            $0?.layer.cornerRadius = 10
            $0?.applyCardShadow()
        }
        
        // Grey (#D1D1D1) border for text-field containers
        [nameContainer, emailContainer, passwordContainer,
         dobContainer, genderContainer, phoneContainer].forEach {
            $0?.applyBorder()
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dobField {
            showDropdown(datePicker, below: dobField)
            return false // Prevent keyboard
        }
        if textField == genderField {
            showDropdown(genderPicker, below: genderField)
            return false
        }
        hideDropdowns()
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            dobField.becomeFirstResponder()
        case dobField:
            genderField.becomeFirstResponder()
        case genderField:
            phoneField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - UIPickerView
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { genders.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { genders[row] }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderField.text = genders[row]
    }
}

// MARK: - UIView Styling Extensions
extension UIView {
    /// Adds a card-like drop shadow
    func applyCardShadow(radius: CGFloat = 8) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
    /// Adds a subtle grey border (#D1D1D1)
    func applyBorder(color: UIColor = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1.0), width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}

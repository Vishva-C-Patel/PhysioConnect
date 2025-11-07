//
//  DoctorListViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 05/11/25.
//

import UIKit
import CoreLocation

class DoctorListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UISearchBarDelegate, FilterDelegate {
    
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var calendarButton: UIButton!
    
    
    @IBOutlet weak var datePickerHeight: NSLayoutConstraint!
    
    
    var doctors: [Doctor] = []
        var filteredDoctors: [Doctor] = []
        let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        title = "Find a Physiotherapist"
        //view.backgroundColor = .systemGroupedBackground
        
        setupTableView()
        setupSearchBar()
        setupDatePicker()
        setupLocation()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func didApplyFilters(_ filters: FilterModel) {
            // Apply filtering logic here
            print("Filters applied: \(filters)")
            // e.g., filter doctors array here
        }
    
    private func setupTableView() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.rowHeight = 154
        }
    
    private func setupSearchBar() {
            searchBar.delegate = self
            searchBar.placeholder = "Search by name or specialization"
            searchBar.searchTextField.backgroundColor = UIColor.white
            searchBar.backgroundImage = UIImage()
            searchBar.backgroundColor = .clear
        
            let textField = searchBar.searchTextField
            
            // 👇 Make corners more rounded
            textField.layer.cornerRadius = 18
            textField.clipsToBounds = true
        
        }
    
    private func setupDatePicker() {
        datePicker.isHidden = true
            datePickerHeight.constant = 0      // collapsed by default
            datePicker.datePickerMode = .dateAndTime
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        }
    
    private func setupLocation() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let loc = locations.first else { return }
            CLGeocoder().reverseGeocodeLocation(loc) { placemarks, _ in
                if let city = placemarks?.first?.locality {
                    DispatchQueue.main.async {
                        self.cityLabel.text = city
                    }
                }
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            cityLabel.text = "Location Unavailable"
        }
    
    @IBAction func calendarButtonTapped(_ sender: UIButton) {
        let shouldShow = datePicker.isHidden
            UIView.animate(withDuration: 0.3) {
                self.datePicker.isHidden = !shouldShow
                self.datePickerHeight.constant = shouldShow ? 200 : 0
                self.view.layoutIfNeeded()     // animate the layout change
                
            }
        }
    
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let filterVC = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController {
                filterVC.modalPresentationStyle = .overFullScreen
                filterVC.delegate = self
                present(filterVC, animated: false)
            }
    }
    
        
        @objc func dateChanged(_ sender: UIDatePicker) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            dateTimeLabel.text = formatter.string(from: sender.date)
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredDoctors.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath) as? DoctorCell else {
                return UITableViewCell()
            }
            let doctor = filteredDoctors[indexPath.row]
            cell.configure(with: doctor)
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }

    

        
        // MARK: - Search Logic
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                filteredDoctors = doctors
            } else {
                filteredDoctors = doctors.filter {
                    $0.name.lowercased().contains(searchText.lowercased()) ||
                    $0.specialization.lowercased().contains(searchText.lowercased())
                }
            }
            tableView.reloadData()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        
        // MARK: - Data
        private func loadData() {
            doctors = [
                Doctor(name: "Dr. David Patel", rating: 5.0, reviews: 405, distance: "within 5 km", specialization: "Knee pain specialist", fees: "₹1000/hr", imageName: "doc1"),
                Doctor(name: "Dr. Sukrit Bhatnagar", rating: 4.5, reviews: 300, distance: "within 7 km", specialization: "Back pain specialist", fees: "₹600/hr", imageName: "doc2"),
                Doctor(name: "Dr. Keerti Singh", rating: 4.0, reviews: 250, distance: "within 15 km", specialization: "Neck pain specialist", fees: "₹750/hr", imageName: "doc3"),
                Doctor(name: "Dr. Laasika Rai", rating: 5.0, reviews: 435, distance: "within 3 km", specialization: "Knee pain specialist", fees: "₹1500/hr", imageName: "doc4")
            ]
            filteredDoctors = doctors
            tableView.reloadData()
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

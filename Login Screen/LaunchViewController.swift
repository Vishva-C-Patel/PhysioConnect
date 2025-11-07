import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var physiotherapistButton: UIButton!
    @IBOutlet weak var patientButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func physiotherapistTapped(_ sender: UIButton) {
        // Move to SignUpViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }

    @IBAction func patientTapped(_ sender: UIButton) {
        // If you want later, navigate to patient signup
    }
}

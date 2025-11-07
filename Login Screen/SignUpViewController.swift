import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUpTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let createAccountVC = storyboard.instantiateViewController(withIdentifier: "CreateAccountViewController") as? CreateAccountViewController {
            self.navigationController?.pushViewController(createAccountVC, animated: true)
        }
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        // Navigation for login later
    }
}

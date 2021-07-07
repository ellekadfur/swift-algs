import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Properties -
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    private var viewModel: ViewModel?
    
    //MARK: - Actions -
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {//TODO: check size of strings, add other validations, such as password etc
            self.present(DisplayAlert.alertBlock(), animated: true)
            return
        }
        viewModel = ViewModel()
        viewModel?.login(username, password) { [weak self] isSuccess in
            self?.viewModel = nil
            if isSuccess {
                self?.performSegue(withIdentifier: "showDomainSearch", sender: self)
            } else {
                self?.present(DisplayAlert.alertBlock(), animated: true)
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}

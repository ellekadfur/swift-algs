import Foundation
import UIKit

class DomainSearchViewController: UIViewController {
    
    struct Domain {
        let name: String
        let price: String
        let productId: Int
    }
    
    //MARK: - Properties -
    @IBOutlet var searchTermsTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var cartButton: UIButton!
    var data: [Domain]?
    private var viewModel: ViewModel?
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCartButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CartViewController, let data = data {
            vc.domains = data
        }
    }
    
    //MARK: - Setup -
    func setupCartButton() {
        cartButton.isEnabled = !CartManager.shared.domains.isEmpty
        cartButton.backgroundColor = cartButton.isEnabled ? .black : .lightGray
    }
    
    //MARK: - Actions -
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchTermsTextField.resignFirstResponder()
        guard let searchTerms = searchTermsTextField.text else {
            present(DisplayAlert.alertBlock(), animated: true)
            return
        }

        viewModel = ViewModel()
        viewModel?.search(searchTerms) { [weak self] (isSuccess, domains) in
            self?.viewModel = nil
            if isSuccess {
                self?.data = domains
                self?.tableView.reloadData()
            } else {
                self?.present(DisplayAlert.alertBlock(), animated: true)
            }
        }
    }
    
    @IBAction func cartButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showCart", sender: self)
    }

}

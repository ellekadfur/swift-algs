import UIKit

class PaymentMethodsViewController: UIViewController {
    
    struct PaymentMethod: Decodable {
        let name: String
        let token: String
        let lastFour: String?
        let displayFormattedEmail: String?
    }
    
    //MARK: - Properties -
    @IBOutlet var tableView: UITableView!
    var paymentMethods: [PaymentMethod]?
    var onSelectPaymentMethod: (() -> Void)?
    private var viewModel: ViewModel? = ViewModel()
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetch() { [weak self] paymentMethods in
            self?.paymentMethods = paymentMethods
            self?.tableView.reloadData()
        }
    }
}


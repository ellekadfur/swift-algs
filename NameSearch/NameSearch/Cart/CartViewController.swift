import UIKit

class CartViewController: UIViewController {
    
    
    //MARK: - Properties -
    @IBOutlet var payButton: UIButton!
    @IBOutlet var tableView: UITableView!
    private var viewModel: ViewModel?
    private var paymentCompletionBlock: ((DisplayAlert.Data) -> Void)?
    var domains: [DomainSearchViewController.Domain] = []
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PaymentMethodsViewController
        vc.onSelectPaymentMethod = { [weak self] in
            self?.updatePayButton()
        }
    }
    
    //MARK: - Setup -
    private func setup() {
        paymentCompletionBlock = { [weak self]  obj in
            self?.payButton.isEnabled = true
            self?.present(DisplayAlert.alertBlock(title: obj.title, message: obj.message, okAction: obj.okAction), animated: true)
        }
        
        tableView.register(UINib(nibName: "CartItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CartItemCell")
        
        updatePayButton()
    }
    
    //MARK: - Actions -
    @IBAction func payButtonTapped(_ sender: UIButton) {
        if PaymentsManager.shared.selectedPaymentMethod == nil {
            performSegue(withIdentifier: "showPaymentMethods", sender: self)
        } else {
            payButton.isEnabled = false
       
            guard let auth = LoginManager.shared.loginViewResponse?.token else {  paymentCompletionBlock?(DisplayAlert.Data(title: "Oops!", message: "Token does not exist.", okAction: nil)); return }
            
            viewModel = ViewModel()
            viewModel?.pay(auth, PaymentsManager.shared.selectedPaymentMethod!.token) { [weak self] obj in
                self?.viewModel = nil
                self?.paymentCompletionBlock?(DisplayAlert.Data(title: obj.title, message: obj.message, okAction: obj.okAction))
            }
        }
    }
    
    //MARK: - Utilities -
    func updatePayButton() {
        if PaymentsManager.shared.selectedPaymentMethod == nil {
            payButton.setTitle("Select a Payment Method", for: .normal)
        } else {
            var totalPayment = 0.00
            
            domains.forEach {
                let priceDouble = Double($0.price.replacingOccurrences(of: "$", with: ""))!
                totalPayment += priceDouble
            }
            
            let currencyFormatter = NumberFormatter()
            currencyFormatter.numberStyle = .currency
            payButton.setTitle("Pay \(currencyFormatter.string(from: NSNumber(value: totalPayment))!) Now", for: .normal)
        }
    }

}


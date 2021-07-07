import UIKit


class CartItemTableViewCell: UITableViewCell {

    //MARK: - Properties -
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var removeButton: UIButton!
    var onRemoveFromCart: (()->Void)?
    
    //MARK: - Actions -
    @IBAction func removeFromCartButtonTapped(_ sender: UIButton) {
        CartManager.shared.domains = CartManager.shared.domains.filter { $0.name != nameLabel.text! }
        onRemoveFromCart?()
    }
    
}

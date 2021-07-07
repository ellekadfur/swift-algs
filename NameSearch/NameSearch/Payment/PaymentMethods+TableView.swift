//
//  PaymentMethod+TableView.swift
//  NameSearch
//
//  Created by Lamar Caaddfiir on 7/7/21.
//  Copyright © 2021 GoDaddy Inc. All rights reserved.
//

import Foundation
import UIKit

extension PaymentMethodsViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource -
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)

        let method = paymentMethods![indexPath.row]

        cell.textLabel!.text = method.name

        if let lastFour = method.lastFour {
            cell.detailTextLabel!.text = "Ending in \(lastFour)"
        } else {
            cell.detailTextLabel!.text = method.displayFormattedEmail!
        }

        return cell
    }
    
    //MARK: - UITableViewDelegate -
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let method = paymentMethods![indexPath.row]
        PaymentsManager.shared.selectedPaymentMethod = method
        dismiss(animated: true) { [weak self] in
            self?.onSelectPaymentMethod?()
        }
    }
}

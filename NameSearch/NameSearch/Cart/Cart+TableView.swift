//
//  CartView+TableView.swift
//  NameSearch
//
//  Created by Lamar Caaddfiir on 7/7/21.
//  Copyright © 2021 GoDaddy Inc. All rights reserved.
//

import Foundation
import UIKit

extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return domains.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemTableViewCell
        cell.nameLabel.text = domains[indexPath.row].name
        cell.priceLabel.text = domains[indexPath.row].price
        cell.onRemoveFromCart = { [weak self] in
            self?.updatePayButton()
            self?.tableView.reloadData()
        }
        return cell
    }
}


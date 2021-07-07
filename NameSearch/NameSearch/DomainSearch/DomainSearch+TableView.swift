//
//  DomainSearch+TableView.swift
//  NameSearch
//
//  Created by Lamar Caaddfiir on 7/6/21.
//  Copyright © 2021 GoDaddy Inc. All rights reserved.
//

import Foundation
import UIKit


extension DomainSearchViewController: UITableViewDataSource,  UITableViewDelegate  {
    
    //MARK: - UITableViewDataSource -
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.textLabel!.text = data![indexPath.row].name
        cell.detailTextLabel!.text = data![indexPath.row].price
        
        let selected = CartManager.shared.domains.contains(where: { $0.name == data![indexPath.row].name })
        
        DispatchQueue.main.async {
            cell.setSelected(selected, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //MARK: - : UITableViewDelegate  -
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let domain = data![indexPath.row]
        CartManager.shared.domains.append(domain)
        
        setupCartButton()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let domain = data![indexPath.row]
        CartManager.shared.domains = CartManager.shared.domains.filter { $0.name != domain.name }
        
        setupCartButton()
    }
}

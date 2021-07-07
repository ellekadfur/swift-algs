//
//  PaymentMethod+ViewModel.swift
//  NameSearch
//
//  Created by Lamar Caaddfiir on 7/7/21.
//  Copyright © 2021 GoDaddy Inc. All rights reserved.
//

import Foundation

extension PaymentMethodsViewController {
    struct ViewModel {
        
        private let service: Service
        
        init(mockService: Service) {
          service = mockService
        }
        
        func fetch(completion: (([PaymentMethodsViewController.PaymentMethod]?)->Void)?) {
            let request = URLRequest(url: URL(string: "https://gd.proxied.io/user/payment-methods")!)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard error == nil else { completion?(nil); return }
                    do {
                        completion?(try JSONDecoder().decode([PaymentMethod].self, from: data!))
                    } catch {
                        completion?(nil)
                    }
                }
            }
            task.resume()
        }
        
    }
}

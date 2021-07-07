//
//  CardView+ViewModel.swift
//  NameSearch
//
//  Created by Lamar Caaddfiir on 7/7/21.
//  Copyright © 2021 GoDaddy Inc. All rights reserved.
//

import Foundation

extension CartViewController {
    struct ViewModel {
    
        private let service: Service
        
        init(mockService: Service) {
          service = mockService
        }
        
        func pay(_ auth: String, _ token: String, completion: ((DisplayAlert.Data) -> Void)?) {
            var request = URLRequest(url: URL(string: "https://gd.proxied.io/payments/process")!)
            request.httpMethod = "POST"
            request.httpBody = try! JSONSerialization.data(withJSONObject: [
                "auth": auth,
                "token": token
            ], options: .fragmentsAllowed)
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        completion?(DisplayAlert.Data(title: "Oops!", message: error.localizedDescription, okAction: nil))
                    } else {
                        completion?(DisplayAlert.Data(title: "All done!", message: "Your purchase is complete!", okAction: nil))
                    }
                }
            }
            task.resume()
        }
        
    }
}

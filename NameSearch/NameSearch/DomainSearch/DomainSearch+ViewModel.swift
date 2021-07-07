//
//  DomainSearch+ViewMoel.swift
//  NameSearch
//
//  Created by Lamar Caaddfiir on 7/6/21.
//  Copyright © 2021 GoDaddy Inc. All rights reserved.
//

import Foundation

extension DomainSearchViewController {
    struct ViewModel {
        
        private let service: Service
        
        init(mockService: Service) {
          service = mockService
        }
        
        func search(_ searchTerm: String, completion: ((Bool, [Domain]?) -> Void)?) {
            let session = URLSession(configuration: .default)
            
            var urlComponents = URLComponents(string: "https://gd.proxied.io/search/exact")!
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: searchTerm)
            ]
            
            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request) { (data, response, error) in
                guard error == nil else { completion?(false, nil); return }
                
                if let data = data {
                    let exactMatchResponse = try! JSONDecoder().decode(ExactMatchResponse.self, from: data)
                    
                    var suggestionsComponents = URLComponents(string: "https://gd.proxied.io/search/spins")!
                    suggestionsComponents.queryItems = [
                        URLQueryItem(name: "q", value: searchTerm)
                    ]
                    
                    var suggestionsRequest = URLRequest(url: suggestionsComponents.url!)
                    suggestionsRequest.httpMethod = "GET"
                    
                    let suggestionsTask = session.dataTask(with: suggestionsRequest) { (suggestionsData, suggestionsResponse, suggestionsError) in
                        guard error == nil else { completion?(false, nil); return }

                        if let suggestionsData = suggestionsData {
                            let suggestionsResponse = try! JSONDecoder().decode(RecommendedResponse.self, from: suggestionsData)
                            
                            let exactDomainPriceInfo = exactMatchResponse.products.first(where: { $0.productId == exactMatchResponse.domain.productId })!.priceInfo
                            let exactDomain = Domain(name: exactMatchResponse.domain.fqdn,
                                                     price: exactDomainPriceInfo.currentPriceDisplay,
                                                     productId: exactMatchResponse.domain.productId)
                            
                            let suggestionDomains = suggestionsResponse.domains.map { domain -> Domain in
                                let priceInfo = suggestionsResponse.products.first(where: { price in
                                    price.productId == domain.productId
                                })!.priceInfo
                                
                                return Domain(name: domain.fqdn, price: priceInfo.currentPriceDisplay, productId: domain.productId)
                            }
                            
                            DispatchQueue.main.async {
                                completion?(true, [exactDomain] + suggestionDomains)
                            }
                        }
                    }
                    suggestionsTask.resume()
                }
            }
            
            task.resume()
        }
    }
}

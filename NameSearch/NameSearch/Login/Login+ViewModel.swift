//
//  LoginView+VM.swift
//  NameSearch
//
//  Created by Lamar Caaddfiir on 7/6/21.
//  Copyright © 2021 GoDaddy Inc. All rights reserved.
//

import Foundation

extension LoginViewController {
    struct ViewModel {
        
        func login(_ username: String, _ password: String, completion: ((Bool) -> Void)? = nil) {
            var request = URLRequest(url: URL(string: "https://gd.proxied.io/auth/login")!)
            request.httpMethod = "POST"
            request.httpBody = try! JSONSerialization.data(withJSONObject: [
                "username": username,
                "password": password
            ], options: .fragmentsAllowed)
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard error == nil else { completion?(false); return }
                    let authReponse = try! JSONDecoder().decode(Response.self, from: data!)
                    
                    LoginManager.shared.loginViewResponse?.user = authReponse.user
                    LoginManager.shared.loginViewResponse?.token = authReponse.token
                    completion?(true)
                }
            }
            task.resume()
        }
        
    }
}

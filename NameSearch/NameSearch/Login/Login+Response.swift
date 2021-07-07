//
//  LoginView+Models.swift
//  NameSearch
//
//  Created by Lamar Caaddfiir on 7/6/21.
//  Copyright © 2021 GoDaddy Inc. All rights reserved.
//

import Foundation

extension LoginViewController {
    struct Response: Decodable {
        var token: String?
        var user: User?
        struct User: Decodable {
            let first: String
            let last: String
        }
    }
}

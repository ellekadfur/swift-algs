//
//  DisplayAlert.swift
//  NameSearch
//
//  Created by Lamar Caaddfiir on 7/6/21.
//  Copyright © 2021 GoDaddy Inc. All rights reserved.
//

import Foundation
import UIKit

class DisplayAlert {
    
    struct Data {
        let title: String
        let message: String
        let okAction: (() -> Void)?
    }
    
    class func alertBlock(title: String = "Oops!", message: String = "Please try again", okAction: (()->Void)? = nil) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
            okAction?()
        }
        controller.addAction(action)
        return controller
    }
    
}

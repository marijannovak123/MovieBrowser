//
//  StringExtensions.swift
//  Autism Helper iOS
//
//  Created by UHP Digital Mac 3 on 11.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}

//
//  AppTextField.swift
//  MovieBrowser
//
//  Created by UHP Mac on 25/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit

class AppTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 12, left: 40, bottom: 12, right: 32))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 12, left: 40, bottom: 12, right: 32))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 12, left: 40, bottom: 12, right: 32))
    }
}

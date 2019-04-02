//
//  ReusableCell.swift
//  ios learning
//
//  Created by UHP Digital Mac 3 on 30.01.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

protocol ReusableCell  {
    associatedtype Data
    
    static var identifier: String { get }
    
    func configure(with data: Data)
}

extension ReusableCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}


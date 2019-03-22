//
//  ReusableCollectionCell.swift
//  BeersApp
//
//  Created by Marijan on 01/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import UIKit

protocol ReusableCollectionCell where Self: UICollectionViewCell  {
    associatedtype Data
    
    static var identifier: String { get }
    
    func configure(with data: Data)
}

extension ReusableCollectionCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}

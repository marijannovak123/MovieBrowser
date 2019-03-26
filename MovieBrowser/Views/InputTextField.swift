//
//  InputTextField.swift
//  MovieBrowser
//
//  Created by UHP Mac on 26/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit

class InputTextField: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: AppTextField!
    @IBOutlet weak var inputImage: UIImageView!
    @IBOutlet weak var errorImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("InputTextField", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.frame = self.frame
        self.addSubview(contentView)
    }
    
}

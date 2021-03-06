//
//  ValidatableTextField.swift
//  MovieBrowser
//
//  Created by UHP Mac on 25/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct ValidatedText {
    let value: String?
    let isValid: Bool
}

class ValidatableTextField: AppTextField {
    
    weak var errorLabel: UILabel? {
        didSet {
            errorLabel?.isHidden = true
        }
    }
    
    // default not empty
    var inputType: InputType? = .regularText
    
    //avoid setting error to textfield that has only been focused and no text has been entered yet
    var isAtOriginalState: Bool = true
    
    var validatedText: Driver<ValidatedText> {
        return self.rx.text.asDriver()
            .do(onNext: {
                if $0 != nil && !$0!.isEmpty {
                    self.isAtOriginalState = false
                }
            })
            .map { ValidatedText(value: $0, isValid: self.validate()) }
    }
    
    func setValidState() {
        self.clearsOnBeginEditing = false
        self.layer.borderWidth = 0
        if let label = errorLabel {
            label.text = ""
            label.isHidden = true
        }
    }
    
    func setFailedValidation(_ failedValidation: ValidationType) {
        if !isAtOriginalState {
            setError(message: failedValidation.resolveFailedValidationMessage())
        }
    }
    
    func setError(message: String) {
        if let label = errorLabel {
            label.text = message
            label.isHidden = false
        }
        self.text = ""
        self.clearsOnBeginEditing = true
        self.layer.borderWidth = 2.0
        self.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }
    
    func validate() -> Bool {
        if let value = self.text {
            if let validationTypes = inputType?.validationTypes {
                for validationType in validationTypes {
                    var valid = true
                    switch validationType {
                    case .notEmpty:
                        valid = !value.isEmpty
                    case .isEmail:
                        valid = value.isValidEmail()
                    case .requiredLength(let length):
                        valid = value.count >= length
                    }
                    
                    if !valid {
                        setFailedValidation(validationType)
                        return false
                    } else {
                        setValidState()
                    }
                }
            }
            
        } else {
            setFailedValidation(.notEmpty)
            return false
        }
        
        return true
    }
    
}

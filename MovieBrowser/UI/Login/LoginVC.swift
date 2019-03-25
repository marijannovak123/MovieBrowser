//
//  LoginVC.swift
//  MovieBrowser
//
//  Created by UHP Mac on 22/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit
import RxCocoa

class LoginVC: BaseViewController<LoginVM> {

    @IBOutlet weak var bLogin: UIButton!
    @IBOutlet weak var tfUsername: ValidatableTextField!
    @IBOutlet weak var tfPassword: ValidatableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func bindToViewModel() {
        let trigger = bLogin.rx.tap
            .asDriver()
            .do(onNext: { self.changeInitialInputState() }) // to vm
        
        let input = LoginVM.Input(
            loginTrigger: trigger,
            username: tfUsername.validatedText,
            password: tfPassword.validatedText
        )
        
        let output = viewModel.transform(input: input)
        
        output.loginResult.drive(onNext: {
            switch $0 {
            case .error(let message):
                self.showMessage(message)
            case .success:
                self.navigate(to: .swipe)
            }
        }).disposed(by: disposeBag)
    }
    
    private func changeInitialInputState() {
        if tfUsername.isAtOriginalState || tfPassword.isAtOriginalState {
            tfUsername.isAtOriginalState = false
            tfPassword.isAtOriginalState = false
            
            _ = tfUsername.validate()
            _ = tfPassword.validate()
        }
    }
}

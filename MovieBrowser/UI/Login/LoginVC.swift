//
//  LoginVC.swift
//  MovieBrowser
//
//  Created by UHP Mac on 22/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit
import RxCocoa
import Moya

class LoginVC: BaseViewController<LoginVM> {

    @IBOutlet weak var bLogin: UIButton!
    @IBOutlet weak var tfUsername: ValidatableTextField!
    @IBOutlet weak var tfPassword: ValidatableTextField!
    @IBOutlet weak var lUsernameError: UILabel!
    @IBOutlet weak var lPasswordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUsername.errorLabel = lUsernameError
        tfPassword.errorLabel = lPasswordError
    }

    override func bindToViewModel() {
        let input = LoginVM.Input(
            username: tfUsername.validatedText,
            password: tfPassword.validatedText
        )
        
        let output = viewModel.transform(input: input)
        
        bLogin.rx.action = output.loginAction
       
        output.loginAction
            .elements
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        output.loginAction
            .errors
            .subscribe {
                $0.map {
                    if let error =  as? MoyaError {
                        print(NetworkError(error))
                    }
                }
              
            }.disposed(by: disposeBag)
        
        output.isLoading
            .drive(onNext: { [unowned self] in
                self.showLoading($0)
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

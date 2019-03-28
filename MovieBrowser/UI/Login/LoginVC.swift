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
    @IBOutlet weak var lUsernameError: UILabel!
    @IBOutlet weak var lPasswordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        
        tfUsername.errorLabel = lUsernameError
        tfPassword.errorLabel = lPasswordError
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
        
        output.loginSuccess
            .drive(onNext: {
                self.navigate(to: .swipe)
            })
            .disposed(by: disposeBag)
        
        output.loginError
            .drive(onNext: { self.showErrorMessage($0) } )
            .disposed(by: disposeBag)
        
        output.isLoading
            .drive(onNext: { self.showLoading($0) })
            .disposed(by: disposeBag)
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

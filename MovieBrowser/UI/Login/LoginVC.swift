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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func bindToViewModel() {
        let input = LoginVM.Input(
            loginTrigger: bLogin.rx.tap.asDriver(),
            username: Driver.just("username"),
            password: Driver.just("password")
        )
        let output = viewModel.transform(input: input)
        
        output.loginResult.drive(onNext: {
            print($0)
        }).disposed(by: disposeBag)
    }
}

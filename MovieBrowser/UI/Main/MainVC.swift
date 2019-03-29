//
//  MainVC.swift
//  MovieBrowser
//
//  Created by UHP Mac on 28/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit

class MainVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = MainMenu.allCases.compactMap {
            let vc = $0.screen.getController()
            vc?.tabBarItem = $0.tabBarItem
            return vc
        }
    }

}

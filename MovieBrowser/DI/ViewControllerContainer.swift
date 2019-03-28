//
//  ViewControllerContainer.swift
//  MovieBrowser
//
//  Created by Marijan on 23/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Swinject

class ViewControllerContainer {
    
    static func build(viewModelContainer: Container) -> Container {
        let container = Container(parent: viewModelContainer)
        
        container.register(LoginVC.self) {
            LoginVC(viewModel: $0.resolve(LoginVM.self)!)
        }
        
        container.register(SwipeVC.self) { _ in
            SwipeVC()
        }
       
        container.register(MainVC.self) { _ in
            MainVC()
        }
        
        container.register(TrendingVC.self) { _ in
            TrendingVC()
        }
        
        container.register(AccountVC.self) { _ in
            AccountVC()
        }
        
        container.register(SearchVC.self) { _ in
            SearchVC()
        }
        
        return container
    }
}

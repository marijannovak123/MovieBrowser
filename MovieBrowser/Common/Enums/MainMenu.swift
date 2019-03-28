//
//  MainMenu.swift
//  MovieBrowser
//
//  Created by UHP Mac on 28/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit

enum MainMenu: CaseIterable {
    case trending
    case search
    case account
    
    var screen: Screen {
        switch self {
        case .trending:
            return .trending
        case .search:
            return .search
        case .account:
            return .account
        }
    }
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .trending:
            
        case .search:
            
        case .account:
            
        }
    }
    
}

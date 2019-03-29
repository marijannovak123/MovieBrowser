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
            return UITabBarItem(title: "Trending", image: #imageLiteral(resourceName: "trending"), tag: 0)
        case .search:
            return UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "find"), tag: 1)
        case .account:
            return UITabBarItem(title: "Account", image: #imageLiteral(resourceName: "account"), tag: 2)
        }
    }
    
}

import UIKit

enum Screen {
    
    case login
    case swipe
    case main
    
    //main menu
    case trending
    case search
    case account
    
    func getController() -> UIViewController? {
        let container = AppDelegate.instance.viewControllerContainer!
        
        var controller: UIViewController?
       
        switch self {
        case .login:
            controller = container.resolve(LoginVC.self)!
        case .swipe:
            controller = container.resolve(SwipeVC.self)!
        case .main:
            controller = container.resolve(MainVC.self)!
        case .trending:
            controller = container.resolve(TrendingVC.self)!
        case .search:
            controller = container.resolve(SearchVC.self)!
        case .account:
            controller = container.resolve(AccountVC.self)!
        }
        
        if self.isRootController() {
            return UINavigationController(rootViewController: controller!)
        } else {
            return controller
        }
    }
    
    func isRootController() -> Bool {
        switch self {
        case .trending, .search, .account:
            return true
        default:
            return false
        }
    }
}


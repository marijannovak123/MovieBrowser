import UIKit

enum Screen {
    
    case login
    case swipe
    case main
    
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
        }
        
        if self.isRootController() {
            return UINavigationController(rootViewController: controller!)
        } else {
            return controller
        }
    }
    
    func isRootController() -> Bool {
        return false
    }
}


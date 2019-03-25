import UIKit

enum Screen {
    
    case login
    case swipe
    
    func getController() -> UIViewController? {
        let container = AppDelegate.instance.viewControllerContainer!
        
        var controller: UIViewController?
       
        switch self {
        case .login:
            controller = container.resolve(LoginVC.self)!
        case .swipe:
            controller = container.resolve(SwipeVC.self)!
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


import UIKit

enum Screen {
    
    func getController() -> UIViewController? {
        let container = AppDelegate.instance.viewControllerContainer
        
        var controller: UIViewController?
       
        if self.isRootController() {
            return UINavigationController(rootViewController: controller!)
        } else {
            return controller
        }
    }
    
    func isRootController() -> Bool {
        return true
    }
}


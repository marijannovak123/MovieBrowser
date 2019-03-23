import UIKit

extension UIViewController {
    
    func navigate(to screen: Screen, animated: Bool = true) {
        let nextController = screen.getController()
        if let navigationController = self.navigationController {
            if screen.isRootController() {
                self.present(nextController!, animated: animated, completion: nil)
            } else {
                navigationController.pushViewController(nextController!, animated: animated)
            }
        } else {
            self.present(nextController!, animated: animated, completion: nil)
        }
    }
    
    func pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            self.dismiss(animated: animated, completion: completion)
        }
    }
    
}

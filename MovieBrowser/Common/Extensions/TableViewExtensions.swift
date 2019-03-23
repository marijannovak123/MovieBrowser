import UIKit
import RxSwift
import RxCocoa

extension UITableView {
    
    func registerCell<T: ReusableCell>(cellType: T.Type) {
        self.register(UINib(nibName: cellType.identifier, bundle: nil), forCellReuseIdentifier: cellType.identifier)
        self.tableFooterView = UIView() // removes empty rows
    }
    
    func dequeueReusableCell<T: ReusableCell>(cellType: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T
    }

}

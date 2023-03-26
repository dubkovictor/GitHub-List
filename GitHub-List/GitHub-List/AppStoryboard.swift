//
//  AppStoryboard.swift
//  GitHub-List
//
//  Created by Victor on 26.03.2023.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case mainViewController = "MainViewController"
//    case secondViewController = "SecondViewController"
//    case thirdViewController = "ThirdViewController"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T>(vc : T.Type) -> T where T: UIViewController {
        let identifier = String(describing: T.self)
        return self.instance.instantiateViewController(withIdentifier: identifier) as! T
    }
}


extension UITableView {
    func dequeue<T: UITableViewCell>(cellForRowAt indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }
}

//  Copyright © 2020 Lohan Marques. All rights reserved.

import Foundation
import UIKit

class TabBarRouter: TabBarRouterProtocol {
    
    static func createModule(tabs: [TabBarViewRouterProtocol]) -> UITabBarController? {
        guard let view = storyboard.instantiateViewController(withIdentifier: "tabBarVC") as? TabBarViewController else { return nil }
        
        var viewControllers = [UIViewController]()
        
        for tab in tabs {
            guard let viewController = tab.configureViewForTab() else { break }
            let navigationController = UINavigationController(rootViewController: viewController)
            
            viewControllers.append(navigationController)
        }
        
        view.viewControllers = viewControllers
        
        return view
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "TabBar", bundle: Bundle.main)
    }
}

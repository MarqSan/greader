//  Copyright © 2020 Lohan Marques. All rights reserved.

import Foundation
import UIKit

protocol TabBarRouterProtocol {
    static func createModule(tabs: [TabBarViewRouterProtocol]) -> UITabBarController?
}

protocol TabBarViewRouterProtocol {
    func configureViewForTab() -> UIViewController?
}

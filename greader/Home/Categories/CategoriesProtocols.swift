//  Copyright © 2020 Lohan Marques. All rights reserved.

import UIKit

protocol CategoriesPresenterToRouterProtocol: class {
    static func createModule(articles: [Article], category: Category) -> UIViewController?
}

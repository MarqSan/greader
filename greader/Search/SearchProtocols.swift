//  Copyright © 2020 Lohan Marques. All rights reserved.

import UIKit

protocol SearchPresenterToViewProtocol: class {
    func showArticles(articles: [Article])
    func showArticlesError(error: ServiceError)
}

protocol SearchPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController?
}

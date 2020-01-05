//  Copyright © 2020 Lohan Marques. All rights reserved.

import UIKit

protocol ArticleDetailsPresenterToRouterProtocol: class {
    static func createModule(article: Article) -> UIViewController?
}

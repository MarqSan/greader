//  Copyright © 2020 Lohan Marques. All rights reserved.

import UIKit

class CategoriesRouter: CategoriesPresenterToRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Categories", bundle: Bundle.main)
    }
    
    static func createModule(articles: [Article], category: Category) -> UIViewController? {
        guard let view = storyboard.instantiateViewController(withIdentifier: "categoriesVC") as? CategoriesViewController else { return nil }
        
        view.articles = articles
        view.category = category
        
        return view
    }
}

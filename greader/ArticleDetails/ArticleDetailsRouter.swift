//  Copyright © 2020 Lohan Marques. All rights reserved.

import UIKit

class ArticleDetailsRouter: ArticleDetailsPresenterToRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "ArticleDetails", bundle: Bundle.main)
    }
    
    static func createModule(article: Article) -> UIViewController? {
        guard let view = storyboard.instantiateViewController(withIdentifier: "articleDetailsVC") as? ArticleDetailsViewController else { return nil }
        
        view.article = article
        
        return view
    }
    
    
}

//  Copyright © 2020 Lohan Marques. All rights reserved.

import Foundation
import UIKit

class SearchRouter: SearchPresenterToRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Search", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController? {
        guard let view = storyboard.instantiateViewController(withIdentifier: "searchVC") as? SearchViewController else { return nil }
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
    func toArticleDetailsScreen(from view: SearchPresenterToViewProtocol?, article: Article) {
        guard let articleDetailsVC = ArticleDetailsRouter.createModule(article: article) else { return }
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(articleDetailsVC, animated: true)
        }
    }
}

// MARK: TAB
extension SearchRouter: TabBarViewRouterProtocol {
 
    func configureViewForTab() -> UIViewController? {
        return SearchRouter.createModule()
    }
}

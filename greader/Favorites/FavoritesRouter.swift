//  Copyright © 2020 Lohan Marques. All rights reserved.

import UIKit

class FavoritesRouter: FavoritesPresenterToRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Favorites", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController? {
        guard let view = storyboard.instantiateViewController(withIdentifier: "favoritesVC") as? FavoritesViewController else { return nil }
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
    func toArticleDetailsScreen(from view: FavoritesPresenterToViewProtocol?, article: Article) {
        guard let articleDetailsVC = ArticleDetailsRouter.createModule(article: article) else { return }
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(articleDetailsVC, animated: true)
        }
    }
}

// MARK: TAB
extension FavoritesRouter: TabBarViewRouterProtocol {
 
    func configureViewForTab() -> UIViewController? {
        return FavoritesRouter.createModule()
    }
}

//  Copyright © 2020 Lohan Marques. All rights reserved.

import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController? {
        guard let view = storyboard.instantiateViewController(withIdentifier: "homeVC") as? HomeViewController else { return nil }
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
    func toCategoriesScreen(from view: HomePresenterToViewProtocol?, articles: [Article], category: Category) {
        guard let categoriesVC = CategoriesRouter.createModule(articles: articles, category: category) else { return }
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(categoriesVC, animated: true)
        }
    }
    
    func toArticleDetailsScreen(from view: HomePresenterToViewProtocol?, article: Article) {
        guard let articleDetailsVC = ArticleDetailsRouter.createModule(article: article) else { return }
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(articleDetailsVC, animated: true)
        }
    }
}

// MARK: TAB
extension HomeRouter: TabBarViewRouterProtocol {
 
    func configureViewForTab() -> UIViewController? {
        return HomeRouter.createModule()
    }
}

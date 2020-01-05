//  Copyright © 2020 Lohan Marques. All rights reserved.

import UIKit

protocol FavoritesPresenterToViewProtocol: class {
    func showFavoritesAsArticles(articles: [Article])
}

protocol FavoritesInteractorToPresenterProtocol: class {
    func favoritesFetched(favorites: [Favorite])
}

protocol FavoritesPresenterToInteractorProtocol: class {
    var presenter: FavoritesInteractorToPresenterProtocol? { get set }
    
    func fetchFavorites()
}

protocol FavoritesPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController?
    
    func toArticleDetailsScreen(from view: FavoritesPresenterToViewProtocol?, article: Article)
}

protocol FavoritesViewToPresenterProtocol: class {
    var view: FavoritesPresenterToViewProtocol? { get set }
    var interactor: FavoritesPresenterToInteractorProtocol? { get set }
    var router: FavoritesPresenterToRouterProtocol? { get set }
    
    func getFavorites()
    func toArticleDetails(article: Article)
}

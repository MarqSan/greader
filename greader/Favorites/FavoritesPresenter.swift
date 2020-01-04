//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

class FavoritesPresenter: FavoritesViewToPresenterProtocol {
    var view: FavoritesPresenterToViewProtocol?
    var interactor: FavoritesPresenterToInteractorProtocol?
    var router: FavoritesPresenterToRouterProtocol?
    
    func getFavorites() {
        interactor?.fetchFavorites()
    }
}

extension FavoritesPresenter: FavoritesInteractorToPresenterProtocol {
    
    func favoritesFetched(favorites: [Favorite]) {
        var articles: [Article] = []
        
        for favorite in favorites {
            articles.append(favorite.toArticle())
        }
        
        view?.showFavoritesAsArticles(articles: articles)
    }
}

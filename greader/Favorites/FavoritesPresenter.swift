//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

class FavoritesPresenter: FavoritesViewToPresenterProtocol {
    
    var view: FavoritesPresenterToViewProtocol?
    var interactor: FavoritesPresenterToInteractorProtocol?
    var router: FavoritesPresenterToRouterProtocol?
    
    func getFavorites() {
        interactor?.fetchFavorites()
    }
    
    func toArticleDetails(article: Article) {
        router?.toArticleDetailsScreen(from: view, article: article)
    }
}

extension FavoritesPresenter: FavoritesInteractorToPresenterProtocol {
    
    func favoritesFetched(favorites: [Favorite]) {
        let articles = convertFavoritesToArticles(favorites)
        
        view?.showFavoritesAsArticles(articles: articles)
    }
    
    func convertFavoritesToArticles(_ favorites: [Favorite]) -> [Article] {
        var articles: [Article] = []
        
        for favorite in favorites {
            articles.append(favorite.toArticle())
        }
        
        return articles
    }
}

//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

// MARK: VIEW
class HomePresenter: HomeViewToPresenterProtocol {
    
    // MARK: VARIABLES
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    var articles: [Article]?
    
    // MARK: CALLS
    func getArticles() {
        interactor?.fetchArticles()
    }
    
    func getFavorites() {
        interactor?.fetchFavorites()
    }
    
    // MARK: NAVIGATION
    func toCategories(articles: [Article], category: Category) {
        router?.toCategoriesScreen(from: view, articles: articles, category: category)
    }
    
    func toArticleDetails(article: Article) {
        router?.toArticleDetailsScreen(from: view, article: article)
    }
}

// MARK: INTERACTOR
extension HomePresenter: HomeInteractorToPresenterProtocol {
    
    func articlesFetched(articles: [Article]) {
        var fetchedArticles = articles
        
        separateArticlesByCategory(&fetchedArticles)
        sortArticlesByDate(&fetchedArticles)
        
        self.articles = fetchedArticles
        
        getFavorites()
    }
    
    func articlesFetchedFailed(error: ServiceError) {
        view?.showArticlesError(error: error)
    }
    
    func favoritesFetched(favorites: [Favorite]) {
        guard var articles = articles else { return }
        
        if !favorites.isEmpty {
            setArticlesFavorites(articles: &articles, favorites)
        }
        
        view?.showArticles(articles: articles)
    }
}

// MARK: METHODS
extension HomePresenter {
    
    func separateArticlesByCategory(_ articles: inout [Article]) {
        for (idx, article) in articles.enumerated() {
            articles[idx].category = Category.fillCategoryByName(article.categoryName)
        }
    }
    
    func sortArticlesByDate(_ articles: inout [Article]) {
        articles.sort { $0.postDate > $1.postDate }
    }
    
    func setArticlesFavorites(articles: inout [Article], _ favorites: [Favorite]) {
        let favoriteIds = favorites.map { $0.id }
        
        for (idx, article) in articles.enumerated() {
            if favoriteIds.contains(article.id) {
                articles[idx].isFavorite = true
            }
        }
    }
}

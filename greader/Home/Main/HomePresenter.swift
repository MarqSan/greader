//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

class HomePresenter {
    private var service: HomeServiceProtocol!
    private var favoritesService: FavoritesService = FavoritesService()
    
    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }
}

extension HomePresenter {
    
    func getArticles(completion: @escaping ([Article]?, ServiceError?) -> Void) {
        service.getArticles(success: { [weak self] response in
            if var articles = response {
                self?.separateArticlesByCategory(&articles)
                self?.sortArticlesByDate(&articles)
                
                self?.favoritesService.getFavorites { [weak self] favorites in
                    if !favorites.isEmpty {
                        self?.setArticlesFavorites(articles: &articles, favorites)
                    }
                    
                    completion(articles, nil)
                }
                
            } else {
                completion(nil, .emptyData)
            }
            
        }) { err in
            completion(nil, err)
        }
    }
    
    private func separateArticlesByCategory(_ articles: inout [Article]) {
        for (idx, article) in articles.enumerated() {
            articles[idx].category = Category.fillCategoryByName(article.categoryName)
        }
    }
    
    private func sortArticlesByDate(_ articles: inout [Article]) {
        articles.sort { $0.postDate > $1.postDate }
    }
    
    private func setArticlesFavorites(articles: inout [Article], _ favorites: [Favorite]) {
        let favoriteIds = favorites.map { $0.id }
        
        for (idx, article) in articles.enumerated() {
            if favoriteIds.contains(article.id) {
                articles[idx].isFavorite = true
            }
        }
    }
}

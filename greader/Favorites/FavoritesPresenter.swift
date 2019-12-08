//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

class FavoritesPresenter {
    private var service: FavoritesServiceProtocol!
    
    init(service: FavoritesServiceProtocol = FavoritesService()) {
        self.service = service
    }
}

extension FavoritesPresenter {
    
    func getFavorites(completion: @escaping ([Favorite]) -> Void) {
        service.getFavorites { favorites in
            completion(favorites)
        }
    }
    
    func getFavoritesAsArticles(completion: @escaping ([Article]) -> Void) {
        service.getFavorites { favorites in
            var articles: [Article] = []
            
            for favorite in favorites {
                articles.append(favorite.toArticle())
            }
            
            completion(articles)
        }
    }
}

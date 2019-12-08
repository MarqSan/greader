//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

protocol FavoritesServiceProtocol {
    func getFavorites(completion: (_ favorites: [Favorite]) -> Void)
}

class FavoritesService: FavoritesServiceProtocol {
    
    func getFavorites(completion: ([Favorite]) -> Void) {
        let favorites = CoreDataManager.get(Favorite.self)
        
        completion(favorites)
    }
}

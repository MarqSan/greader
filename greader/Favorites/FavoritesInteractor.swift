//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

class FavoritesInteractor: FavoritesPresenterToInteractorProtocol {
    var presenter: FavoritesInteractorToPresenterProtocol?
    
    func fetchFavorites() {
        let favorites = CoreDataManager.get(Favorite.self)
        
        presenter?.favoritesFetched(favorites: favorites)
    }
}

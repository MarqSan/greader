//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

class FavoritesViewController: UIViewController {

    // MARK: VARIABLES
    var presenter: FavoritesPresenter!
}

// MARK: LIFECYCLE
extension FavoritesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = FavoritesPresenter()
        
        getFavorites()
    }
}

// MARK: PRESENTER
extension FavoritesViewController {
    
    private func getFavorites() {
        presenter.getFavorites { favorites in
            print(favorites)
        }
    }
}

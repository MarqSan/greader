//  Copyright © 2019 Lohan Marques. All rights reserved.

import XCTest
@testable import G_Reader

class FavoritesTests: XCTestCase {
    
    var presenter: FavoritesPresenter!
    var favorite: Favorite!

    override func setUp() {
        super.setUp()
        
        presenter = FavoritesPresenter()
    }

    override func tearDown() {
        super.tearDown()
        
        presenter = nil
        removeFavorite()
    }
}

// MARK: INTEGRATIONS
extension FavoritesTests {
    
    func testGetFavorites() {
        persistFavorite()
        
        presenter.getFavorites { favorites in
            XCTAssertNotNil(favorites)
//            XCTAssertEqual(favorites.count, 1)
        }
    }
    
    func testGetFavoritesAsArticles() {
        persistFavorite()
        
        presenter.getFavoritesAsArticles { [weak self] articles in
            XCTAssertNotNil(articles)
            XCTAssertEqual(articles[0].title, self?.favorite.title)
            XCTAssertNotNil(articles[0].isFavorite)
            XCTAssertTrue(articles[0].isFavorite!)
        }
    }
}

// MARK: HELPERS
extension FavoritesTests {

    func persistFavorite() {
        favorite = Favorite(context: CoreDataManager.context)
        
        favorite.id = 1
        favorite.categoryName = "Tecnologia"
        favorite.content = "Conteudo 1"
        favorite.title = "Artigo 1"
        favorite.author = "Autor 1"
        favorite.postDate = ""
        
        CoreDataManager.save()
    }
    
    func removeFavorite() {
        CoreDataManager.deleteAll()
    }
}

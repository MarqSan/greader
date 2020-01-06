//  Copyright © 2019 Lohan Marques. All rights reserved.

import XCTest
@testable import G_Reader

class FavoritesTests: XCTestCase {
    
    var presenter: FavoritesPresenter!
    var interactor: FavoritesInteractor!
    var mockPresenter: MockFavoritesPresenter!
    
    var favorite: Favorite!

    override func setUp() {
        super.setUp()
        
        mockPresenter = MockFavoritesPresenter()
        
        presenter = FavoritesPresenter()
        interactor = FavoritesInteractor()
        
        interactor.presenter = mockPresenter
        presenter.interactor = interactor
        
        persistFavorite()
    }

    override func tearDown() {
        super.tearDown()
        
        removeFavorite()
    }
}

class MockFavoritesPresenter: FavoritesInteractorToPresenterProtocol {
    
    var favorites: [Favorite]!
    var promise: XCTestExpectation!
    
    func favoritesFetched(favorites: [Favorite]) {
        self.favorites = favorites
        
        promise.fulfill()
    }
}

// MARK: INTEGRATIONS
extension FavoritesTests {

    func testFetchFavorites() {
        let promise = XCTestExpectation(description: #function)
        mockPresenter.promise = promise
        
        interactor.fetchFavorites()
        
        wait(for: [promise], timeout: 10)
        
        XCTAssertNotNil(mockPresenter.favorites)
        XCTAssertEqual(mockPresenter.favorites.count, 1)
    }

    func testGetFavorites() {
        let articles = presenter.convertFavoritesToArticles([favorite])
        
        XCTAssertNotNil(articles)
        XCTAssertEqual(articles[0].title, favorite.title)
        XCTAssertNotNil(articles[0].isFavorite)
        XCTAssertTrue(articles[0].isFavorite!)
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

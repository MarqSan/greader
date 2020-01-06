//  Copyright © 2019 Lohan Marques. All rights reserved.

import XCTest
@testable import G_Reader

class ArticleTests: XCTestCase {
    
    var presenter: HomePresenter!
    var interactor: HomeInteractor!
    var mockView: MockHomeView!
    var mockPresenter: MockHomePresenter!
    
    var favorite: Favorite!

    override func setUp() {
        super.setUp()
        
        mockView = MockHomeView()
        mockPresenter = MockHomePresenter()
        
        presenter = HomePresenter()
        interactor = HomeInteractor()
        
        presenter?.view = mockView
        interactor.presenter = mockPresenter
        
        mockView.articles = [
            Article(id: 1, image: "", categoryName: "Tecnologia", title: "Artigo 1", author: "", postDate: "03/12/2019 15:30", content: ""),
            Article(id: 2, image: "", categoryName: "Esportes", title: "Artigo 2", author: "", postDate: "02/12/2019 20:30", content: ""),
            Article(id: 3, image: "", categoryName: "Tecnologia", title: "Artigo 3", author: "", postDate: "03/12/2019 20:30", content: ""),
            Article(id: 4, image: "", categoryName: "Esportes", title: "Artigo 4", author: "", postDate: "04/12/2019 15:30", content: "")
        ]
        
        persistFavorite()
    }

    override func tearDown() {
        super.tearDown()
        
        presenter = nil
        mockView = nil
        removeFavorite()
    }
}

// MARK: MOCKS
class MockHomeView: HomePresenterToViewProtocol {
    
    var articles: [Article]!
    var errorGetArticles: ServiceError?
    
    func showArticles(articles: [Article]) {
        self.articles = articles
    }
    
    func showArticlesError(error: ServiceError) {
        errorGetArticles = error
    }
}

class MockHomePresenter: HomeInteractorToPresenterProtocol {
    
    var articles: [Article]!
    var errorGetArticles: ServiceError?
    var promise: XCTestExpectation!
    
    func articlesFetched(articles: [Article]) {
        self.articles = articles
        
        promise.fulfill()
    }
    
    func articlesFetchedFailed(error: ServiceError) {
        errorGetArticles = error
        
        promise.fulfill()
    }
    
    // TODO: Need refactor because violates Interface Segregation principle
    func favoritesFetched(favorites: [Favorite]) {
        return
    }
}

// MARK: UNITS
extension ArticleTests {

    func testSeparateArticlesByCategory() {
        presenter?.separateArticlesByCategory(&mockView.articles)

        XCTAssertNotNil(mockView.articles[0].category)
        XCTAssertEqual(mockView.articles[0].category?.name, mockView.articles[0].categoryName)
    }

    func testSortArticlesByDate() {
        presenter.sortArticlesByDate(&mockView.articles)

        XCTAssert(mockView.articles[0].postDate > mockView.articles[1].postDate)
    }

    func testSetArticlesFavorites() {
        let favorites: [Favorite] = [favorite]

        presenter.setArticlesFavorites(articles: &mockView.articles, favorites)

        XCTAssertNotNil(mockView.articles[0].isFavorite)
        XCTAssertTrue(mockView.articles[0].isFavorite ?? false)
    }
}

// MARK: INTEGRATIONS
extension ArticleTests {
    
    func testFetchArticles() {
        let promise = expectation(description: #function)
        mockPresenter.promise = promise
        
        interactor.fetchArticles()
        
        wait(for: [promise], timeout: 10)
        
        XCTAssertNil(mockPresenter.errorGetArticles)
        XCTAssertNotNil(mockPresenter.articles)
        
        if let articles = mockPresenter.articles {
            XCTAssert(articles.count > 0)
        }
    }
    
    func testFetchEmptyArticles() {
        var emptyData = Data()
        var fullData: Data?
        
        fullData = try? JSONEncoder().encode(mockView.articles)
        
        if fullData == nil {
           return XCTFail()
        }
        
        emptyData = interactor.checkIfContainsArticles(data: emptyData)
        fullData = interactor.checkIfContainsArticles(data: fullData!)
        
        XCTAssertTrue(emptyData.isEmpty)
        XCTAssertFalse(fullData!.isEmpty)
    }
    
    func testFetchFailedArticles() {
        API.articles = "wrong_url"
        
        let promise = expectation(description: #function)
        mockPresenter.promise = promise
        
        interactor.fetchArticles()
        
        wait(for: [promise], timeout: 10)
        
        XCTAssertNotNil(mockPresenter.errorGetArticles)
    }
    
    func testFetchArticlesWithParseError() {
        guard let data = "{ id: 1 }".data(using: .utf8) else {
            return XCTFail()
        }
        
        let articles = try? interactor.decodeArticles(data: data)
        
        XCTAssertNil(articles)
    }
}

// MARK: HELPERS
extension ArticleTests {

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

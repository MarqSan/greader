//  Copyright © 2019 Lohan Marques. All rights reserved.

import XCTest
@testable import G_Reader

class ArticleTests: XCTestCase {
    
    var presenter: HomePresenter!
    var articles: [Article] = []
    var favorite: Favorite!

    override func setUp() {
        super.setUp()
        
        presenter = G_Reader.HomePresenter()
        
        articles = [
            Article(id: 1, image: "", categoryName: "Tecnologia", title: "Artigo 1", author: "", postDate: "03/12/2019 15:30", content: ""),
            Article(id: 2, image: "", categoryName: "Esportes", title: "Artigo 2", author: "", postDate: "02/12/2019 20:30", content: ""),
            Article(id: 3, image: "", categoryName: "Tecnologia", title: "Artigo 3", author: "", postDate: "03/12/2019 20:30", content: ""),
            Article(id: 4, image: "", categoryName: "Esportes", title: "Artigo 4", author: "", postDate: "04/12/2019 15:30", content: "")
        ]
        
        favorite = Favorite(context: CoreDataManager.context)
        favorite.id = 1
        favorite.title = "Artigo 1"
    }

    override func tearDown() {
        super.tearDown()
        
        presenter = nil
        articles = []
    }
}

// MARK: UNITS
extension ArticleTests {
    
    func testSeparateArticlesByCategory() {
        presenter.separateArticlesByCategory(&articles)
        
        XCTAssertNotNil(articles[0].category)
        XCTAssertEqual(articles[0].category?.name, articles[0].categoryName)
    }
    
    func testSortArticlesByDate() {
        presenter.sortArticlesByDate(&articles)
        
        XCTAssert(articles[0].postDate > articles[1].postDate)
    }
    
    func testSetArticlesFavorites() {
        let favorites: [Favorite] = [favorite]
        
        presenter.setArticlesFavorites(articles: &articles, favorites)
        
        XCTAssertNotNil(articles[0].isFavorite)
        XCTAssertTrue(articles[0].isFavorite ?? false)
    }
}

// MARK: INTEGRATIONS
extension ArticleTests {
    
    func testGetArticles() {
        presenter.getArticles { (articles, err) in
            XCTAssertNil(err)
            XCTAssertNotNil(articles)
            
            if let articles = articles {
                XCTAssert(articles.count > 0)
            }
        }
    }
}

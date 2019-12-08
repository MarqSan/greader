//  Copyright © 2019 Lohan Marques. All rights reserved.

import XCTest
@testable import G_Reader

class SearchTests: XCTestCase {
    
    var searchVC: SearchViewController!
    var articles: [Article] = []
    var searchedArticles: [Article] = []

    override func setUp() {
        super.setUp()
        
        searchVC = SearchViewController()
    
        searchVC.articles = [
            Article(id: 1, image: "", categoryName: "Tecnologia", title: "Artigo 1", author: "", postDate: "03/12/2019 15:30", content: "Conteudo 1"),
            Article(id: 2, image: "", categoryName: "Esportes", title: "Artigo 2", author: "", postDate: "02/12/2019 20:30", content: "Conteudo 2"),
            Article(id: 3, image: "", categoryName: "Tecnologia", title: "Artigo 3", author: "", postDate: "03/12/2019 20:30", content: "Conteudo 3"),
            Article(id: 4, image: "", categoryName: "Esportes", title: "Artigo 4", author: "", postDate: "04/12/2019 15:30", content: "Conteudo 4")
        ]
    }

    override func tearDown() {
        super.tearDown()
        
        searchVC = nil
        articles = []
    }
}

// MARK: UNITS
extension SearchTests {
    
    func testUpdateArticlesOnSearch() {
        searchedArticles = searchVC.updateArticlesOnSearch(text: "1")
        
        XCTAssertEqual(searchedArticles.count, 1)
    }
}

//  Copyright © 2019 Lohan Marques. All rights reserved.

import XCTest
@testable import G_Reader

class CategoryTests: XCTestCase {
    
    var article: Article!

    override func setUp() {
        super.setUp()
        
        article = Article(id: 1, image: "", categoryName: "Tecnologia", title: "Artigo 1", author: "", postDate: "03/12/2019 15:30", content: "")
    }

    override func tearDown() {
        super.tearDown()
        
        article = nil
    }
}

// MARK: UNITS
extension CategoryTests {
    
    func testFillCategoryByName() {
        let category = Category.fillCategoryByName(article.categoryName)
        
        XCTAssertNotNil(category)
        XCTAssertEqual(category!.name, article.categoryName)
    }
}

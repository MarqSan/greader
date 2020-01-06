//  Copyright © 2019 Lohan Marques. All rights reserved.

import XCTest

class HomeUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }
    
    func testEnterArticleDetailsWithContent() {
        let cell = app.tables.element(boundBy: 0).cells.element(boundBy: 0)
        
        cell.tap()
        
        let content = app.textViews.matching(identifier: "articleContent")
        
        XCTAssertFalse(content.staticTexts["Conteúdo"].exists)
    }
}

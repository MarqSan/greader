//  Copyright © 2020 Lohan Marques. All rights reserved.

import Foundation
import UIKit

protocol HomePresenterToViewProtocol: class {
    func showArticles(articles: [Article])
    func showArticlesError(error: ServiceError)
}

protocol HomeInteractorToPresenterProtocol: class {
    func articlesFetched(articles: [Article])
    func articlesFetchedFailed(error: ServiceError)
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter: HomeInteractorToPresenterProtocol? { get set }
    
    func fetchArticles()
}

protocol HomePresenterToRouterProtocol: class {
    static func createModule() -> UIViewController?
    
    func toCategoriesScreen(from view: HomePresenterToViewProtocol?, articles: [Article], category: Category)
    func toArticleDetailsScreen(from view: HomePresenterToViewProtocol?, article: Article)
}

protocol HomeViewToPresenterProtocol: class {
    var view: HomePresenterToViewProtocol? { get set }
    var interactor: HomePresenterToInteractorProtocol? { get set }
    var router: HomePresenterToRouterProtocol? { get set }
    
    func getArticles()
    func toCategories(articles: [Article], category: Category)
    func toArticleDetails(article: Article)
}

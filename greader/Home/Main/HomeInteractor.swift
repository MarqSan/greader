//  Copyright © 2020 Lohan Marques. All rights reserved.

import Foundation
import Alamofire

class HomeInteractor: HomePresenterToInteractorProtocol {
    var presenter: HomeInteractorToPresenterProtocol?
    
    func fetchArticles() {
        AF.request(API.articles, method: .get)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                    case .success:
                        let data = self.checkIfContainsArticles(data: response.data)
                        
                        if data.isEmpty {
                            self.presenter?.articlesFetched(articles: [])
                            return
                        }
                        
                        do {
                            let articles = try self.decodeArticles(data: data)
                            
                            self.presenter?.articlesFetched(articles: articles!)
                            
                        } catch {
                            self.presenter?.articlesFetchedFailed(error: .emptyData)
                        }
                    
                    case .failure:
                        self.presenter?.articlesFetchedFailed(error: .unknownError)
                        break
                }
        }
    }
    
    // TODO: Need refactor to avoid repetition
    func fetchFavorites() {
        let favorites = CoreDataManager.get(Favorite.self)
        
        presenter?.favoritesFetched(favorites: favorites)
    }
    
    func checkIfContainsArticles(data: Data?) -> Data {
        return data ?? .empty
    }
    
    func decodeArticles(data: Data) throws -> [Article]? {
        let articles = try? JSONDecoder().decode([Article].self, from: data)
        
        return articles
    }
}

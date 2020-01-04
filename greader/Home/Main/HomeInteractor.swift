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
                        guard let data = response.data else {
                            self.presenter?.articlesFetched(articles: [])
                            return
                        }
                        
                        do {
                            let articles = try JSONDecoder().decode([Article].self, from: data)
                            
                            self.presenter?.articlesFetched(articles: articles)
                            
                        } catch {
                            self.presenter?.articlesFetchedFailed(error: .emptyData)
                        }
                    
                    case .failure:
                        self.presenter?.articlesFetchedFailed(error: .unknownError)
                        break
                }
        }
    }
}

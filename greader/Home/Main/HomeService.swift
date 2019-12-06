//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation
import Alamofire

protocol HomeServiceProtocol {
    func getArticles(success: @escaping(_ articles: [Article]?) -> Void, failure: @escaping(_ error: ServiceError) -> Void)
}

class HomeService: HomeServiceProtocol {
    
    func getArticles(success: @escaping ([Article]?) -> Void, failure: @escaping (ServiceError) -> Void) {
        
        AF.request(API.articles, method: .get)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                    case .success:
                        guard let data = response.data else { return success(nil) }
                        
                        do {
                            let articles = try JSONDecoder().decode([Article].self, from: data)
                            success(articles)
                            
                        } catch {
                            failure(.emptyData)
                        }
                    
                    case .failure:
                        failure(.unknownError)
                        break
                }
        }
    }
    
}

//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

class HomePresenter {
    private var service: HomeServiceProtocol!
    
    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }
}

extension HomePresenter {
    
    func getArticles(completion: @escaping ([Article]?, ServiceError?) -> Void) {
        
        service.getArticles(success: { [weak self] response in
            if var articles = response {
                self?.separateArticlesByCategory(&articles)
                self?.sortArticlesByDate(&articles)
                
                completion(articles, nil)
                
            } else {
                completion(nil, .emptyData)
            }
            
        }) { err in
            completion(nil, err)
        }
    }
    
    private func separateArticlesByCategory(_ articles: inout [Article]) {
        for (idx, article) in articles.enumerated() {
            articles[idx].category = Category.fillCategoryByName(article.categoryName)
        }
    }
    
    private func sortArticlesByDate(_ articles: inout [Article]) {
        articles.sort { $0.postDate > $1.postDate }
    }
}

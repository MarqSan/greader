//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

struct Article: Decodable {
    let id: Int32
    let image: String
    let categoryName: String
    let title: String
    let author: String
    let postDate: String
    var category: Category?
    var isFavorite: Bool? = false
    
    func storeAsFavorite() {
        prepareEntity()
        CoreDataManager.save()
    }
    
    func removeFromFavorites() {
        if let favorite = CoreDataManager.findByID(id) {
            CoreDataManager.delete(favorite)
        }
    }
    
    private func prepareEntity() {
        let favorite = Favorite(context: CoreDataManager.context)
        
        favorite.id = Int32(id)
        favorite.image = image
        favorite.categoryName = categoryName
        favorite.title = title
        favorite.author = author
        favorite.postDate = postDate
    }
}

//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

struct Article: Decodable {
    let id: Int32
    let image: String
    let categoryName: String
    let title: String
    let author: String
    let postDate: String
    var content: String
    var category: Category?
    var isFavorite: Bool? = false
}

// MARK: CORE DATA
extension Article {
    
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
        favorite.content = content
    }
}

// MARK: TABLEVIEW
extension Article {
    
    func instantiateCell(_ tableView: UITableView, indexPath: IndexPath) -> ArticleCell {
        let nibCell = UINib(nibName: String(describing: ArticleCell.self), bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: ArticleCell.identifier)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
        
        cell.article = self
        
        cell.setupCell()
        cell.applyStyles()
        
        return cell
    }
}

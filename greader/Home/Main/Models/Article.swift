//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit
import Kingfisher

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

// MARK: COREDATA
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

// MARK: METHODS
extension Article {
    
    func setFavoriteStyle(button: UIButton) {
        guard let favorite = isFavorite else { return }
        
        let favoriteColor = favorite ? UIColor(named: Colors.primary) : UIColor(named: Colors.complementary)
        button.tintColor = favoriteColor
    }
    
    func handleFavoriteStore() {
        let favorite = isFavorite ?? false
        
        if favorite {
            storeAsFavorite()
        } else {
            removeFromFavorites()
        }
    }
    
    func setThumbnail(imageView: UIImageView) {
        if image.isEmpty {
            imageView.image = UIImage(named: "img_no-image")
            return
        }
        
        guard let url = URL(string: image) else { return }
        let resource = ImageResource(downloadURL: url)
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: resource)
    }
}

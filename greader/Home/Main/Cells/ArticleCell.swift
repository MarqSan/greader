//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

protocol ArticleCellDelegate: NSObjectProtocol {
    func tappedFavoriteButton(id: Int32)
}

class ArticleCell: UITableViewCell {
    
    // MARK: OUTLETS
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var relativeTime: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: VARIABLES
    static let height: CGFloat = 250
    static let identifier: String = "article"
    weak var delegate: ArticleCellDelegate?
    var article: Article!
    
    // MARK: ACTIONS
    @IBAction func setFavorite(_ sender: Any) {
        guard var isFavorite = article.isFavorite else { return }
        
        isFavorite = !isFavorite
        
        article.isFavorite = isFavorite
        
        article.setFavoriteStyle(button: favoriteButton)
        favoriteButton.pulse()
        article.handleFavoriteStore()
        
        delegate?.tappedFavoriteButton(id: article.id)
    }
}

// MARK: LIFECYCLE
extension ArticleCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: METHODS
extension ArticleCell {
    
    func setupCell() {
        let postDate = article.postDate.toDate()
        
        article.isFavorite = article.isFavorite ?? false
        
        category.text = article.category?.name
        title.text = article.title
        author.text = article.author
        relativeTime.text = postDate?.relativeTime
        
        article.setThumbnail(imageView: mainImage)
        article.setFavoriteStyle(button: favoriteButton)
    }
    
    func applyStyles() {
        if let category = article.category, let color = category.color {
            self.category.textColor = UIColor(named: color)!
        }
        
        mainView.dropShadow(color: UIColor(named: Colors.shadow) ?? .white)
        title.sizeToFit()
    }
    
    static func notifyArticles(withID id: Int32) {
        NotificationCenter.default.post(name: .articlesUpdate, object: id)
    }
}

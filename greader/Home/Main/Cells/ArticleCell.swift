//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    
    // MARK: OUTLETS
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var relativeTime: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    static let height: CGFloat = 250
    static let identifier: String = "article"
}

// MARK: LIFECYCLE
extension ArticleCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: METHODS
extension ArticleCell {
    
    func setupCell(_ article: Article) {
        let postDate = article.postDate.toDate()
        
        category.text = article.category?.name
        title.text = article.title
        author.text = article.author
        relativeTime.text = postDate?.relativeTime
        
        setThumbnail(article.image)
    }
    
    func applyStyles(_ article: Article) {
        if let category = article.category, let color = category.color {
            self.category.textColor = UIColor(named: color)!
        }
        
        mainView.dropShadow(color: UIColor(named: Colors.shadow) ?? .white)
        title.sizeToFit()
    }
    
    private func setThumbnail(_ image: String) {
        guard let url = URL(string: image) else { return }
        let resource = ImageResource(downloadURL: url)
        
        mainImage.kf.indicatorType = .activity
        mainImage.kf.setImage(with: resource)
    }
}

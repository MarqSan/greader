//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

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
        mainImage.image = UIImage(named: "img_teste")
        category.text = article.category.name
        title.text = article.title
        author.text = article.author
        relativeTime.text = article.relativeTime
    }
    
    func applyStyles(_ article: Article) {
        mainView.dropShadow(color: Colors.shadow)
        category.textColor = article.category.color
        title.sizeToFit()
    }
}

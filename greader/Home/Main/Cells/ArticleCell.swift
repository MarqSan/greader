//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit
import Kingfisher

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
        
        setFavoriteStyle()
        addPulse()
        handleFavoriteStore(willAdd: isFavorite)
        
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
        
        setThumbnail(article.image)
        setFavoriteStyle()
    }
    
    func applyStyles() {
        if let category = article.category, let color = category.color {
            self.category.textColor = UIColor(named: color)!
        }
        
        mainView.dropShadow(color: UIColor(named: Colors.shadow) ?? .white)
        title.sizeToFit()
    }
    
    private func setThumbnail(_ image: String) {
        if image.isEmpty {
            mainImage.image = UIImage(named: "img_no-image")
            return
        }
        
        guard let url = URL(string: image) else { return }
        let resource = ImageResource(downloadURL: url)
        
        mainImage.kf.indicatorType = .activity
        mainImage.kf.setImage(with: resource)
    }
    
    private func setFavoriteStyle() {
        guard let isFavorite = article.isFavorite else { return }
        
        let favoriteColor = isFavorite ? UIColor(named: Colors.primary) : UIColor(named: Colors.complementary)
        favoriteButton.tintColor = favoriteColor
    }
    
    private func handleFavoriteStore(willAdd: Bool) {
        if willAdd {
            article.storeAsFavorite()
        } else {
            article.removeFromFavorites()
        }
    }
}

// MARK: ANIMATIONS
extension ArticleCell {

    private func addPulse() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.favoriteButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.favoriteButton.transform = CGAffineTransform.identity
            }
        })
    }
}

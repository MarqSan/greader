//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

class ArticleDetailsViewController: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: VARIABLES
    var article: Article!
}

// MARK: LIFECYCLE
extension ArticleDetailsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.customizeBackButton(color: UIColor(named: Colors.secondary))
        navigationController?.removeNavBarLine()
        
        setDetails()
    }
}

// MARK: METHODS
extension ArticleDetailsViewController {
    
    private func setDetails() {
        applyCategoryColor()
        
        categoryLabel.text = article.categoryName
        titleLabel.text = article.title
        authorLabel.text = article.author
        postDateLabel.text = article.postDate
        postImageView.image = UIImage(named: article.image) 
        contentLabel.text = article.content
    }
    
    private func applyCategoryColor() {
        if let category = article.category, let color = category.color {
            categoryLabel.textColor = UIColor(named: color) ?? .black
        }
    }
}

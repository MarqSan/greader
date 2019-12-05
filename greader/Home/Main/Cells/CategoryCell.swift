//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: OUTLETS
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    // MARK: VARIABLES
    static let height: CGFloat = 160
    static let identifier: String = "category"
}

// MARK: LIFECYCLE
extension CategoryCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: METHODS
extension CategoryCell {
    
    func setupCell(_ category: Category) {
        guard let categoryImage = category.image,
            let categoryColor = category.color else { return }
        
        name.text = category.name
        image.image = UIImage(named: categoryImage)
        mainView.backgroundColor = UIColor(named: categoryColor)!
    }
}

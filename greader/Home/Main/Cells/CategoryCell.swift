//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let cellHeight: CGFloat = 160
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
}

// MARK: LIFECYCLE
extension CategoryCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension CategoryCell {
    
    func setupCell(_ category: Category) {
        self.name.text = category.name
        self.image.image = UIImage(named: category.image)
        self.mainView.backgroundColor = UIColor(named: category.color)
    }
}

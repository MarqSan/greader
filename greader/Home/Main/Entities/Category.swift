//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

struct Category: Decodable, Encodable {
    let name: String
    var color: String?
    var image: String?
}

// MARK: METHODS
extension Category {
    
    static func getCategories() -> [Category] {
        let categories: [Category] = [
            Category(name: "Tecnologia", color: Colors.categoriesTechnology, image: "img_technology"),
            Category(name: "Esportes", color: Colors.categoriesSports, image: "img_sports"),
            Category(name: "Economia", color: Colors.categoriesEconomy, image: "img_economy"),
            Category(name: "Viagens", color: Colors.categoriesTravels, image: "img_travels")
        ]
        
        return categories
    }
    
    static func fillCategoryByName(_ name: String) -> Category? {
        let categories = Category.getCategories()
        
        return categories.first(where: { $0.name == name })
    }
}

// MARK: TABLEVIEW
extension Category {
    
    func instantiateCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> CategoryCell {
        let nibCell = UINib(nibName: String(describing: CategoryCell.self), bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: CategoryCell.identifier)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        
        cell.setupCell(self)
        
        return cell
    }
}

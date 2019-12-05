//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

struct Category {
    let name: String
    let color: UIColor
    var image: String?
    
    static func getCategories() -> [Category] {
        let categories: [Category] = [
            Category(name: "Tecnologia", color: Colors.categoriesTechnology, image: "img_technology"),
            Category(name: "Esportes", color: Colors.categoriesSports, image: "img_sports"),
            Category(name: "Economia", color: Colors.categoriesEconomy, image: "img_economy"),
            Category(name: "Viagens", color: Colors.categoriesTravels, image: "img_travels")
        ]
        
        return categories
    }
}

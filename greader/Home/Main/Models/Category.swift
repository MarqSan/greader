//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

struct Category: Decodable {
    let name: String
    var color: String?
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
    
    static func fillCategoryByName(_ name: String) -> Category? {
        let categories = Category.getCategories()
        
        return categories.first(where: { $0.name == name })
    }
}

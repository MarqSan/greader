//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

struct Category {
    let name: String
    let image: String
    let color: String
    
    static func getCategories() -> [Category] {
        let categories: [Category] = [
            Category(name: "Tecnologia", image: "img_technology", color: "Technology"),
            Category(name: "Esportes", image: "img_sports", color: "Sports"),
            Category(name: "Economia", image: "img_economy", color: "Economy"),
            Category(name: "Viagens", image: "img_travels", color: "Travels")
        ]
        
        return categories
    }
}

//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation

struct Article: Decodable {
    let id: Int
    let image: String
    let categoryName: String
    let title: String
    let author: String
    let postDate: String
    var category: Category?
    var isFavorite: Bool?
}

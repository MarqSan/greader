//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation
import CoreData

@objc(Favorite)
public class Favorite: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var categoryName: String
    @NSManaged public var title: String
    @NSManaged public var author: String
    @NSManaged public var postDate: String
}

extension Favorite {
    
    func toArticle() -> Article {
        return Article(id: id, image: image ?? "", categoryName: categoryName, title: title, author: author, postDate: postDate, isFavorite: true)
    }
}

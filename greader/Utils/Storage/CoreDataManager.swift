//  Copyright © 2019 Lohan Marques. All rights reserved.

import Foundation
import CoreData

enum CoreDataOperation {
    case save
    case delete
}

class CoreDataManager {
    
    private init() {}
    
    static var entities = ["Favorite"]
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    static var container: NSPersistentContainer = {
        let store = NSPersistentContainer(name: "greader")
        
        store.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Core data error on load \(error) - \(error.userInfo)")
            }
        })
        
        return store
    }()
    
    static func get<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entity = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        do {
            let objects = try context.fetch(fetchRequest) as? [T]
            return objects ?? [T]()
            
        } catch {
            print(error)
            return [T]()
        }
    }
    
    static func save() {
        if container.viewContext.hasChanges {
            do {
                try context.save()
                
            } catch let err as NSError {
                fatalError("Core data error on save: \(err) - \(err.userInfo)")
            }
        }
    }
    
    static func findByID<T: NSManagedObject>(_ id: Int32) -> T? {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate.init(format: "id==\(id)")
        
        do {
            let objects = try context.fetch(request) as? [T]
            
            return objects?.first ?? nil
            
        } catch {
            print(error)
            return nil
        }
    }
    
    static func delete(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
    
    static func deleteAll() {
        for entity in entities {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            fetchRequest.returnsObjectsAsFaults = false
                   
            do {
               let results = try context.fetch(fetchRequest)
               
               for object in results {
                   guard let data = object as? NSManagedObject else { continue }
                   
                   delete(data)
               }
               
            } catch let error {
               print("Detele all data in \(entity) error :", error)
            }
        }
    }
}

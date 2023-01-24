//
//  CoreDataManager.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 24.01.2023.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    /* I had trouble about Singleton structure here and didn't have much time to
     spend on it. After project deadline, I'll focus to write this page clearly.
     For now, the 'Model' pages of my modules contains all core data fetch and
     retrieve operations. My aim is to handle all of them here with re-usable code.
     
     Regards,
     Halil
     */
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameBox")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func deleteAllRecords(entity: String) {
        
        let context = persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("Delete All Error: \(error)")
        }
    }
    
}


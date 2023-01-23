//
//  CoreDataManager.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 24.01.2023.
//

import UIKit
import CoreData

final class CoreDataManager {
 
    static let shared = CoreDataManager()
    private let context: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    

}

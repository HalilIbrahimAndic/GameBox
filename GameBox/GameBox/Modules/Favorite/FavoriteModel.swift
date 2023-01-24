//
//  FavoriteModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 21.01.2023.
//

import UIKit
import CoreData

//MARK: - Protocol
protocol FavoriteModelProtocol: AnyObject {
    func didCacheDataFetch()
    func didDataCouldntFetch()
}

//MARK: - Delegator of FavoriteModelProtocol
class FavoriteModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var favIDs: [Int32] = []
    
    private(set) var data: [RAWGModel] = []
    private(set) var databaseData: [GameEntity] = []
    private(set) var favoriteData: [FavoriteEntity] = []
    
    weak var delegate: FavoriteModelProtocol?
    
    func retrieveFromFavoriteEntity() {
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let request = NSFetchRequest<FavoriteEntity>(entityName: "FavoriteEntity")
            
            let favoriteResults = try context.fetch(request)
            self.favoriteData = favoriteResults
            
            // I need to store the IDs of all favorited games from "FavoriteEntity"
            // to present them in favorite page. This is the solution I Found.
            favIDs = favoriteData.map{$0.id}
        } catch {
            print("Error: Coredata fetching")
            delegate?.didDataCouldntFetch()
        }
    }

    func retrieveFromCoreData() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<GameEntity>(entityName: "GameEntity")
        // Predicated stored IDs inside GameEntity (main DB)
        request.predicate = NSPredicate(format: "id IN %@", favIDs)
        
        do {
            let result = try context.fetch(request)
            self.databaseData = result
            delegate?.didCacheDataFetch()
        } catch {
            delegate?.didDataCouldntFetch()
        }
    }
    
    func deleteSelectedFav (_ favID: Int) {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<FavoriteEntity>(entityName: "FavoriteEntity")
        // Delete only selected game from FavoriteEntity
        request.predicate = NSPredicate(format: "id = %@", String(favID))
        
        do {
            let objects = try context.fetch(request)
            for object in objects {
                context.delete(object)
            }
            try context.save()
        } catch {
            print (error)
        }
    }
    
    func deleteAllRecords(entity: String) {
        let context = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print (error)
        }
    }
}

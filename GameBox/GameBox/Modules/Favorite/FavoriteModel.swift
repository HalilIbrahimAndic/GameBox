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
    
//    func deleteFromFavoriteEntity(_ deleteID: Int) {
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<FavoriteEntity>(entityName: "FavoriteEntity")
//
//        request.predicate = NSPredicate(format: "id = %@", deleteID)
//
//        do {
//            let test = try context.fetch(request)
//            let objectToDelete = test[0] as NSManagedObject
//            context.delete(objectToDelete)
//
//            do {
//                try context.save()
//            } catch {
//                print("delete error: \(error)")
//            }
//        } catch {
//            print("Favorite delete error: \(error)")
//        }
//    }
    
    func retrieveFromFavoriteEntity() {
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let request = NSFetchRequest<FavoriteEntity>(entityName: "FavoriteEntity")
            
            let favoriteResults = try context.fetch(request)
            self.favoriteData = favoriteResults
            favIDs = favoriteData.map{$0.id}
        } catch {
            print("Error: Coredata fetching")
            delegate?.didDataCouldntFetch()
        }
    }

    // favorilenen oyunun detay bilgilerini burada
    // we can limit fetchedCD request with "Predicate?"
    func retrieveFromCoreData() {
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<GameEntity>(entityName: "GameEntity")
        request.predicate = NSPredicate(format: "id IN %@", favIDs)
        
        do {
            let result = try context.fetch(request)
            print("favoriden cache'lnen: \(result.count)")
            self.databaseData = result
            delegate?.didCacheDataFetch()
        } catch {
            print("Error: Coredata fetching")
            delegate?.didDataCouldntFetch()
        }
    }
}

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
            print("\(favoriteResults.count)")
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
        do {
            let request = NSFetchRequest<GameEntity>(entityName: "GameEntity")
            request.predicate = NSPredicate(format: "id IN %@", favIDs)
            
            let result = try context.fetch(request)
            print("\(result.count)")
            self.databaseData = result
            delegate?.didCacheDataFetch()
        } catch {
            print("Error: Coredata fetching")
            delegate?.didDataCouldntFetch()
        }
    }
}

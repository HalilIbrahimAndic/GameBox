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
    
    private(set) var data: [RAWGModel] = []
    private(set) var databaseData: [GameEntity] = []
    
    weak var delegate: FavoriteModelProtocol?

    // favorilenen oyunun detay bilgilerini burada
    // we can limit fetchedCD request with "Predicate?"
    func retrieveFromCoreData() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<GameEntity>(entityName: "GameEntity")
        
        do {
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

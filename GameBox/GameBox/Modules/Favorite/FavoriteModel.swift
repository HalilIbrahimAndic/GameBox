//
//  FavoriteModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 21.01.2023.
//

import Foundation

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
    
    func fetchData() { //No need to check internet, only fetched data can be faved.
            retrieveFromCoreData()
        }

    private func retrieveFromCoreData() {
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
        // we can limit fetchedCD request with "Predicate?"
    }
}

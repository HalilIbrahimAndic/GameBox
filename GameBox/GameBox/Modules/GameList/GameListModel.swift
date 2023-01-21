//
//  GameListModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 15.01.2023.
//

import Foundation
import Alamofire
import CoreData

//MARK: - Protocol
protocol GameListModelProtocol: AnyObject {
    
    func didLiveDataFetch()
    func didCacheDataFetch()
    func didDataCouldntFetch()
}

//MARK: - Delegator of GameListModelProtocol
class GameListModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private(set) var data: [RAWGModel] = []
    private(set) var databaseData: [GameEntity] = []
    
    weak var delegate: GameListModelProtocol?
    
    func fetchData(_ pageNumber: Int) { //First check CoreData, if nil -> fetch from internet
        if InternetManager.shared.isInternetActive() {
            AF.request("https://api.rawg.io/api/games?key=\(Constants.apiKey)&page=\(pageNumber)").responseDecodable(of: ApiData.self) { (res) in
                guard
                    let response = res.value
                else {
                    self.delegate?.didDataCouldntFetch()
                    return
                }
                self.data = response.results
                self.delegate?.didLiveDataFetch()
                
                for item in self.data {
                    self.saveToCoreData(item)
                }
            }
        } else {
            retrieveFromCoreData()
        }
//        deleteAllRecords(entity: "GameEntity")
//        deleteAllRecords(entity: "FavoriteEntity")
//        deleteAllRecords(entity: "DetailEntity")
    }
    
    private func saveToCoreData(_ data: RAWGModel) {
        
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "GameEntity", in: context) {
            let listObject = NSManagedObject(entity: entity, insertInto: context)
            
            listObject.setValue(data.background_image, forKey: "background_image")
            listObject.setValue(data.id, forKey: "id")
            listObject.setValue(data.name, forKey: "name")
            listObject.setValue(data.rating, forKey: "rating")
            listObject.setValue(data.rating_top, forKey: "rating_top")
            listObject.setValue(data.released, forKey: "released")
            
            do {
                try context.save()
            } catch  {
                print("Hata: \(error)")
            }
        }
    }

    private func retrieveFromCoreData() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<GameEntity>(entityName: "GameEntity")
        
        do {
            let result = try context.fetch(request)
            print("gamelistden cache'lenen: \(result.count)")
            self.databaseData = result
            delegate?.didCacheDataFetch()
        } catch {
            print("Error: Coredata fetching")
            delegate?.didDataCouldntFetch()
        }
        // we can limit fetchedCD request with "Predicate?"
    }
    
    func saveToFavData(_ gameID: Int) {
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "FavoriteEntity", in: context) {
            let listObject = NSManagedObject(entity: entity, insertInto: context)
            
            listObject.setValue(gameID, forKey: "id")
            
            do {
                try context.save()
                print("saved in FavData from gamelist")
            } catch  {
                print("Hata: \(error)")
            }
        }
    }
    
    func deleteAllRecords(entity : String) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print ("There was an error")
        }
    }
}

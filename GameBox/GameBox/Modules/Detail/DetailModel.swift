//
//  DetailModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 18.01.2023.
//

import Foundation
import Alamofire
import CoreData

//MARK: - Protocol
protocol DetailModelProtocol: AnyObject {
    
    func didLiveDataFetch()
    func didCacheDataFetch()
    func didDataCouldntFetch()
}

//MARK: - Delegator of DetailModelProtocol
class DetailModel {
    
    weak var detailDelegate: DetailModelProtocol?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private(set) var data = DetailPageModel(id: 0, name: "", background_image: "", rating: 0.0, playtime: 0, reviews_count: 0, platforms: [], genres: [], tags: [], description_raw: "")
    private(set) var databaseData: [DetailEntity] = []
    
    func fetchData(_ gameID: Int) { //First check CoreData, if nil -> fetch from internet
        let api = "https://api.rawg.io/api/games/\(gameID)\(Service.apiKey)"
        
        if InternetManager.shared.isInternetActive() {
            AF.request(api).responseDecodable(of: DetailPageModel.self) { (res) in
                guard
                    let response = res.value
                else {
                    self.detailDelegate?.didDataCouldntFetch()
                    return
                }
                self.data = response
                self.detailDelegate?.didLiveDataFetch()
                self.saveToCoreData(response)
            }
        } else {
            retrieveFromCoreData()
        }
    }
    
    private func saveToCoreData(_ data: DetailPageModel) {
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "DetailEntity", in: context) {
            let listObject = NSManagedObject(entity: entity, insertInto: context)
            
            listObject.setValue(data.id, forKey: "id")
            listObject.setValue(data.name, forKey: "name")
            listObject.setValue(data.background_image, forKey: "background_image")
            listObject.setValue(data.rating, forKey: "rating")
            listObject.setValue(data.playtime, forKey: "playtime")
            listObject.setValue(data.reviews_count, forKey: "reviews_count")
            listObject.setValue(data.description_raw, forKey: "description_raw")
            listObject.setValue(data.genres.map{$0.name}.joined(separator: ", "), forKey: "genre_name")
            listObject.setValue(data.tags.map{$0.name}.joined(separator: ", "), forKey: "tag_name")
            listObject.setValue(data.platforms.map{$0.platform.name}.joined(separator: ", "), forKey: "platform_name")
            
            do {
                try context.save()
            } catch  {
                print(error)
            }
        }
    }
    
    func saveToFavData(_ gameID: Int) {
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "FavoriteEntity", in: context) {
            let listObject = NSManagedObject(entity: entity, insertInto: context)
            
            listObject.setValue(gameID, forKey: "id")
            listObject.setValue(true, forKey: "condition")
            
            do {
                try context.save()
            } catch  {
                print(error)
            }
        }
    }
    
    private func retrieveFromCoreData() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<DetailEntity>(entityName: "DetailEntity")
        
        do {
            let result = try context.fetch(request)
            self.databaseData = result
            detailDelegate?.didCacheDataFetch()
        } catch {
            detailDelegate?.didDataCouldntFetch()
        }
    }
}


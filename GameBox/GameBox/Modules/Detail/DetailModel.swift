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
    private let apiKey = "d04a8d582093458f9cc979cd66f2d71d"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private(set) var data = DetailPageModel(id: 0, name: "", background_image: "", rating: 0.0, playtime: 0, reviews_count: 0, platforms: [], genres: [], tags: [], description_raw: "")
    //private(set) var data: [DetailPageModel] = []
    private(set) var databaseData: [DetailEntity] = []
    
    func fetchData(_ gameID: Int) { //First check CoreData, if nil -> fetch from internet
        let api = "https://api.rawg.io/api/games/\(gameID)?key=\(apiKey)"
        
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
                    print("saved in Detail CoreData")
                } catch  {
                    print("Hata: \(error)")
                }
            }
        }
    
        private func retrieveFromCoreData() {
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<DetailEntity>(entityName: "DetailEntity")
    
            do {
                let result = try context.fetch(request)
                print("\(result.count)")
                self.databaseData = result
                detailDelegate?.didCacheDataFetch()
            } catch {
                print("Error: Coredata fetching")
                detailDelegate?.didDataCouldntFetch()
            }
            // we can limit result request with "Predicate?"
        }
}


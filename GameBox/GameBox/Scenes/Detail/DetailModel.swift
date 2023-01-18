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
    
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private(set) var data: [DetailPageModel] = []
    //private(set) var databaseData: [ListEntity] = []
    
    func fetchData() { //First check CoreData, if nil -> fetch from internet
      if InternetManager.shared.isInternetActive() {
        AF.request("https://api.rawg.io/api/games/3498?key=d04a8d582093458f9cc979cd66f2d71d").responseDecodable(of: [DetailPageModel].self) { (res) in
          guard
            let response = res.value
          else {
            self.detailDelegate?.didDataCouldntFetch()
            return
          }
            self.data = response
            self.detailDelegate?.didLiveDataFetch()
          
//          for item in self.data {
//            self.saveToCoreData(item)
//          }
        }
      } else {
        //retrieveFromCoreData()
      }
    }
    
//    private func saveToCoreData(_ data: RAWGModel) {
//        let context = appDelegate.persistentContainer.viewContext
//        if let entity = NSEntityDescription.entity(forEntityName: "ListEntity", in: context) {
//          let listObject = NSManagedObject(entity: entity, insertInto: context)
//
//            listObject.setValue(data.background_image ?? "", forKey: "background_image")
//            listObject.setValue(data.id ?? 0, forKey: "id")
//            listObject.setValue(data.name ?? "", forKey: "name")
//            listObject.setValue(data.rating ?? 0.0, forKey: "rating")
//            listObject.setValue(data.released ?? "", forKey: "released")
//
//            do {
//                try context.save()
//                //print("saved in CoreData")
//            } catch  {
//                print("Hata: \(error)")
//            }
//        }
//    }
    
//    private func retrieveFromCoreData() {
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<ListEntity>(entityName: "ListEntity")
//
//        do {
//            let fetchedCD = try context.fetch(request)
//            print("\(fetchedCD.count)")
//            self.databaseData = fetchedCD
//            delegate?.didCacheDataFetch()
//        } catch {
//            print("Error: Coredata fetching")
//            delegate?.didDataCouldntFetch()
//        }
//        // we can limit fetchedCD request with "Predicate?"
//    }
}

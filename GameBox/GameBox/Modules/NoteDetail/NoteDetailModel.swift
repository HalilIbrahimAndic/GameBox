//
//  NoteDetailModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit
import CoreData
import Alamofire

//MARK: - Protocol
protocol NoteDetailModelProtocol: AnyObject {
    func didCacheDataFetch()
    func didDataCouldntFetch()
}

class NoteDetailModel {
    
    weak var delegate: NoteDetailModelProtocol?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func saveToCoreData(_ data: NoteCellModel) {
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "NoteEntity", in: context) {
          let listObject = NSManagedObject(entity: entity, insertInto: context)

            listObject.setValue(data.name, forKey: "name")
            listObject.setValue(data.note, forKey: "note")
            listObject.setValue(data.date, forKey: "date")

            do {
                try context.save()
                print("noted in CoreData with name: \(data.name)")
            } catch  {
                print("Hata: \(error)")
            }
        }
    }
    
//    private func retrieveFromCoreData() {
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<DetailEntity>(entityName: "DetailEntity")
//
//        do {
//            let result = try context.fetch(request)
//            print("detailden cache'lenen: \(result.count)")
//            self.databaseData = result
//            detailDelegate?.didCacheDataFetch()
//        } catch {
//            print("Error: Coredata fetching")
//            detailDelegate?.didDataCouldntFetch()
//        }
//    }
}

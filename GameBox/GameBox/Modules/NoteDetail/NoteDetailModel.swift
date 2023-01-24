//
//  NoteDetailModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit
import CoreData

class NoteDetailModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // Saves taken notes in CoreData
    func saveToCoreData(_ data: NoteCellModel) {
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "NoteEntity", in: context) {
          let listObject = NSManagedObject(entity: entity, insertInto: context)

            listObject.setValue(data.name, forKey: "name")
            listObject.setValue(data.note, forKey: "note")
            listObject.setValue(data.date, forKey: "date")

            do {
                try context.save()
            } catch  {
                print(error)
            }
        }
    }
}

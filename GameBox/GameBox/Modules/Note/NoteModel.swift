//
//  NoteModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit
import CoreData

//MARK: - Protocol
protocol NoteModelProtocol: AnyObject {
    func didCacheDataFetch()
    func didDataCouldntFetch()
}

//MARK: - Delegator of NoteModelProtocol
class NoteModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    weak var delegate: NoteModelProtocol?
    var noteIDs: [Int32] = []

    private(set) var noteData: [NoteEntity] = []
    
    private func saveToCoreData(_ data: NoteCellModel) {
        
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "NoteEntity", in: context) {
            let listObject = NSManagedObject(entity: entity, insertInto: context)
            
            listObject.setValue(data.id, forKey: "id")
            listObject.setValue(data.title, forKey: "title")
            listObject.setValue(data.note, forKey: "note")
            listObject.setValue(data.date, forKey: "date")
            
            do {
                try context.save()
            } catch  {
                print("Note save error: \(error)")
            }
        }
    }
    
    private func retrieveFromCoreData() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        
        do {
            let result = try context.fetch(request)
            print("note cache: \(result.count)")
            self.noteData = result
            delegate?.didCacheDataFetch()
        } catch {
            print("Error: Coredata fetching")
            delegate?.didDataCouldntFetch()
        }
    }
}

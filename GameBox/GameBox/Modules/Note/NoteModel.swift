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
    
    private(set) var noteData: [NoteEntity] = []
    
    func retrieveFromNoteEntity() {
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
    
    func deleteSelectedNote (_ noteName: String) {
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        request.predicate = NSPredicate(format: "name = %@", noteName)
        
        do {
            let objects = try context.fetch(request)
            for object in objects {
                context.delete(object)
            }
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func deleteAllRecords(entity: String) {
        
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

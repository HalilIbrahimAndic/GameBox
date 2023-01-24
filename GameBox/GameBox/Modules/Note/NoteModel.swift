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
    
    // checks saved notes from database
    func retrieveFromNoteEntity() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        
        do {
            let result = try context.fetch(request)
            self.noteData = result
            delegate?.didCacheDataFetch()
        } catch {
            delegate?.didDataCouldntFetch()
        }
    }
    
    func deleteSelectedNote (_ noteName: String) {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        // Predicates the specific note wrt. its Title
        request.predicate = NSPredicate(format: "name = %@", noteName)
        
        do {
            let objects = try context.fetch(request)
            // delete every object inside predicated entry
            for object in objects {
                context.delete(object)
            }
            try context.save()
        } catch {
            print (error)
        }
    }
    
    func deleteAllRecords(entity: String) {
        let context = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print (error)
        }
    }
}

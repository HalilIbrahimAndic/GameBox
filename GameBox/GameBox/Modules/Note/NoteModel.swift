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
}

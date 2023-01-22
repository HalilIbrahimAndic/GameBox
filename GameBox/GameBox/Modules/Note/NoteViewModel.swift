//
//  NoteViewModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import Foundation

class NoteViewModel{
    
    private let model = NoteModel()
    
    var onErrorOccured: ((String) -> ())?
    var refreshItems: (([NoteCellModel]) -> ())?
    var deleteID = 0
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.retrieveFromNoteEntity()
    }
    
    func deleteAll() {
        model.deleteAllRecords(entity: "NoteEntity")
        model.retrieveFromNoteEntity()
    }
    
    func deleteNote(_ noteName: String) {
        model.deleteSelectedNote(noteName)
        model.retrieveFromNoteEntity()
    }
}

//MARK: - NoteViewModel Extensions
extension NoteViewModel: NoteModelProtocol {
    
    func didCacheDataFetch() {
        let cellModels: [NoteCellModel] = model.noteData.map{ .init(name: $0.name ?? "", note: $0.note ?? "", date: $0.date ?? Date())}
        refreshItems?(cellModels)
    }
    
    func didDataCouldntFetch() {
        onErrorOccured?("Data Couldn't Fetched. Try Again Later!")
    }
}

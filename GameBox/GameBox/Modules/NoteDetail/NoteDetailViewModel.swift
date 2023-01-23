//
//  NoteDetailViewModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import Foundation

class NoteDetailViewModel {
    private let model = NoteDetailModel()
    
    func saveNote(_ myNote: NoteCellModel) {
        model.saveToCoreData(myNote)
    }
}

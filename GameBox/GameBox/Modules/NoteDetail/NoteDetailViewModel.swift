//
//  NoteDetailViewModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import Foundation

class NoteDetailViewModel {
    
    private let model = NoteDetailModel()
    
    var onErrorOccured: ((String) -> ())?
    var refreshItems: (([NoteCellModel]) -> ())?
    var deleteID = 0
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        //model
    }
    
    func saveNote(_ myNote: NoteCellModel) {
        model.saveToCoreData(myNote)
    }
}

//MARK: - NoteDetailViewModel Extensions
extension NoteDetailViewModel: NoteDetailModelProtocol {
    
    func didCacheDataFetch() {
//        let cellModels: [NoteDetailPageModel] = model.noteDetailData.map{ .init(id: Int($0.id), title: $0.title ?? "")}
//        refreshItems?(cellModels)
    }
    
    func didDataCouldntFetch() {
        onErrorOccured?("Data Couldn't Fetched. Try Again Later!")
    }
}

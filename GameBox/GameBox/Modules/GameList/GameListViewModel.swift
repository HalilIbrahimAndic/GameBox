//
//  GameListViewModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 15.01.2023.
//

import Foundation

//MARK: - Delegate
class GameListViewModel {
    
    private let model = GameListModel()
    
    var onErrorOccured: ((String) -> ())?
    var refreshItems: (([GameListCellModel]) -> ())?
    
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchData()
    }
    
    func itemPressed(_ index: Int){
        // TODO:
    }
}

//MARK: - Extensions
extension GameListViewModel: GameListModelProtocol {
    func didLiveDataFetch() {
        // TODO:
    }
    
    func didCacheDataFetch() {
        // TODO:
    }
    
    func didDataCouldntFetch() {
        // TODO:
    }
    
}

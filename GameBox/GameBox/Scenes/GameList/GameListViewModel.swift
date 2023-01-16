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
        let cellModels: [GameListCellModel] = model.data.map{ .init(name: $0.name ?? "", released: $0.released ?? "", rating: $0.rating ?? 0.0, background_image: $0.background_image ?? "") }
        refreshItems?(cellModels)
    }
    
    func didCacheDataFetch() {
        let cellModels: [GameListCellModel] = model.databaseData.map{ .init(name: $0.name ?? "", released: $0.released ?? "", rating: $0.rating, background_image: $0.background_image ?? "") }
        refreshItems?(cellModels)
    }
    
    func didDataCouldntFetch() {
        onErrorOccured?("Data Couldn't Fetched. Try Again Later!")
    }
    
}

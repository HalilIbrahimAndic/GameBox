//
//  GameListViewModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 15.01.2023.
//

import Foundation

//MARK: - Delegate of GameListModelProtocol
class GameListViewModel{
    
    private let model = GameListModel()
    private let service = Service()
    
    var onErrorOccured: ((String) -> ())?
    var refreshItems: (([GameListCellModel]) -> ())?
    
    var pageNumber = 1
    var apiFlag = 0
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchData(service.sortedAPI(apiFlag), pageNumber)
    }
    
    func didFavPressed(_ gameID: Int) {
        model.saveToFavData(gameID)
    }
}

//MARK: - Extensions
extension GameListViewModel: GameListModelProtocol {
    func didLiveDataFetch() {
        let cellModels: [GameListCellModel] = model.data.map{ .init(id: $0.id, name: $0.name, released: $0.released, rating: $0.rating, background_image: $0.background_image)}
        refreshItems?(cellModels)
    }
    
    func didCacheDataFetch() {
        let cellModels: [GameListCellModel] = model.databaseData.map{ .init(id: Int($0.id), name: $0.name ?? "", released: $0.released ?? "", rating: $0.rating, background_image: $0.background_image ?? "") }
        refreshItems?(cellModels)
    }
    
    func didDataCouldntFetch() {
        onErrorOccured?("Data Couldn't Fetched. Try Again Later!")
    }
}

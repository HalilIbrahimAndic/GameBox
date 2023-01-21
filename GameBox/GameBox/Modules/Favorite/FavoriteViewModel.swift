//
//  FavoriteViewModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 21.01.2023.
//

import Foundation

//MARK: - Delegate of FavoriteModelProtocol
class FavoriteViewModel{
    
    private let model = FavoriteModel()
    
    var onErrorOccured: ((String) -> ())?
    var refreshItems: (([GameListCellModel]) -> ())?
    var deleteID = 0
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.retrieveFromFavoriteEntity()
        model.retrieveFromCoreData()
        
    }
    
//    func didFavDeleted() {
//        //model.deleteFromFavoriteEntity(deleteID)
//    }
}

//MARK: - FavoriteModel Extensions
extension FavoriteViewModel: FavoriteModelProtocol {
    
    // cache'den gelen veriyi VC'ye yolla
    func didCacheDataFetch() {
        let cellModels: [GameListCellModel] = model.databaseData.map{ .init(id: Int($0.id), name: $0.name ?? "", released: $0.released ?? "", rating: $0.rating , rating_top: Int($0.rating_top), background_image: $0.background_image ?? "") }
        refreshItems?(cellModels)
    }
    
    func didDataCouldntFetch() {
        onErrorOccured?("Data Couldn't Fetched. Try Again Later!")
    }
}

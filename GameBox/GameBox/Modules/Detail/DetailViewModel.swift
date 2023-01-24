//
//  DetailViewModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 18.01.2023.
//

import Foundation

//MARK: - Delegate of DetailModelProtocol
class DetailViewModel {

    private let model = DetailModel()
    
    var onErrorOccured: ((String) -> ())?
    var refreshItems: ((DetailPageModel) -> ())?
    var refreshFavItems: ((FavButtonModel) -> ())?
    var refreshCacheItems: (([DetailCacheModel]) -> ())?
    
    init() {
        model.detailDelegate = self
    }

    func didViewLoad(_ gameID: Int) {
        model.fetchData(gameID)
        model.retrieveFromFavData()

    }
    
    func didFavPressed(_ gameID: Int) {
        model.saveToFavData(gameID)
    }
    
    func didFavRemoved(_ gameID:Int) {
        
    }
}

//MARK: - Extensions
extension DetailViewModel: DetailModelProtocol {
    func didLiveDataFetch() {
        let DPModel = DetailPageModel(id: model.data.id, name: model.data.name, background_image: model.data.background_image , rating: model.data.rating , playtime: model.data.playtime , reviews_count: model.data.reviews_count , platforms: model.data.platforms, genres: model.data.genres, tags: model.data.tags, description_raw: model.data.description_raw )
        refreshItems?(DPModel)
    }
    
    func didCacheDataFetch() {      
        let DCModel: [DetailCacheModel] = model.databaseData.map{.init(id: Int($0.id), name: $0.name ?? "", background_image: $0.background_image ?? "", rating: $0.rating, playtime: Int($0.playtime), reviews_count: Int($0.reviews_count), platform_name: $0.platform_name ?? "", genre_name: $0.genre_name ?? "", tag_name: $0.tag_name ?? "", description_raw: $0.description_raw ?? "")}
        refreshCacheItems?(DCModel)
    }
    
    func didFavCache() {
        //let favButtonModel: [FavButtonModel] = model.favData.map{ .init(id: Int($0.id), condition: $0.condition)}
//        let favButtonModel = FavButtonModel(id: 0, condition: false)
//        refreshFavItems?(favButtonModel)
    }
    
    func didDataCouldntFetch() {
        onErrorOccured?("Data Couldn't Fetched. Try Again Later!")
    }
}

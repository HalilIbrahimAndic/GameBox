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
    var refreshItems: (([DetailPageModel]) -> ())?
    
    init() {
        model.detailDelegate = self
    }

    func didViewLoad() {
        //model.fetchData()
    }
}

//MARK: - Extensions
extension DetailViewModel: DetailModelProtocol {
    func didLiveDataFetch() {
        let DPModel: [DetailPageModel] = model.data.map{ .init(id: $0.id , name: $0.name , background_image: $0.background_image , description: $0.description) }
        refreshItems?(DPModel)
    }
    
    func didCacheDataFetch() {
//        let cellModels: [GameListCellModel] = model.databaseData.map{ .init(name: $0.name ?? "", released: $0.released ?? "", rating: $0.rating, background_image: $0.background_image ?? "") }
//        refreshItems?(cellModels)
    }
    
    func didDataCouldntFetch() {
        onErrorOccured?("Data Couldn't Fetched. Try Again Later!")
    }
}

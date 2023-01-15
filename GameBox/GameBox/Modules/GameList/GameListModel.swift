//
//  GameListModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 15.01.2023.
//

import Foundation

//MARK: - Protocol
protocol GameListModelProtocol: AnyObject {
    
    func didDataFetch()
    func didDataCouldntFetch()
}

//MARK: - Delegator
class GameListModel {
    
    private(set) var data: [Any] = []
    
    weak var delegate: GameListModelProtocol?
    
    func fetchData() {
        
    }
    
    
}

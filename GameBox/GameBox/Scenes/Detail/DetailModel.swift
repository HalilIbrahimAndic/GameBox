//
//  DetailModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 18.01.2023.
//

import Foundation
import Alamofire
import CoreData

//MARK: - Protocol
protocol DetailModelProtocol: AnyObject {
    
    func didLiveDataFetch()
    func didCacheDataFetch()
    func didDataCouldntFetch()
}

//MARK: - Delegator of DetailModelProtocol
class DetailModel {
    
}

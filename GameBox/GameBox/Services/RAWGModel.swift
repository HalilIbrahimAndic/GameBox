//
//  RAWGModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 16.01.2023.
//

import Foundation

// MARK: - GameModel
struct ApiData: Decodable {
    //let next: String?
    let results: [RAWGModel]

}

// MARK: - Result
struct RAWGModel: Decodable {
    let id: Int
    let name, released: String
    let background_image: String
    let rating: Double
    let rating_top: Int
}

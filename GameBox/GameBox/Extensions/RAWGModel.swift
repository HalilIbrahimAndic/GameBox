//
//  RAWGModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 16.01.2023.
//

import Foundation

// My main Fetch model.

// MARK: - GameModel
struct ApiData: Decodable {
    let results: [RAWGModel]

}

// MARK: - Result
struct RAWGModel: Decodable {
    let id: Int
    let name, released, slug: String
    let background_image: String
    let rating: Double
}

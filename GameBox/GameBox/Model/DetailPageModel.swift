//
//  DetailPageModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 19.01.2023.
//

import Foundation

struct DetailPageModel: Decodable {
    let id: Int
    let name: String
    //let released: String
    //let rating: Double
    let background_image: String
    let description: String
}

//
//  DetailPageModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 19.01.2023.
//

import Foundation

// Model for 2nd screen

// MARK: - DetailPageModel
struct DetailPageModel: Decodable {
    let id: Int
    let name: String
    let background_image: String
    let rating: Double
    let playtime, reviews_count: Int
    let platforms: [Platform]
    let genres, tags: [Genre]
    let description_raw: String
}

// MARK: - Genre
struct Genre: Decodable {
    let name: String
}

// MARK: - Platform
struct Platform: Decodable {
    let platform: Genre
}

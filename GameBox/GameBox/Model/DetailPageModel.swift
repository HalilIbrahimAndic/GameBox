//
//  DetailPageModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 19.01.2023.
//

import Foundation

// MARK: - DetailPageModel
struct DetailPageModel: Codable {
    let name: String?
    let backgroundImage: String?
    let rating: Double?
    let playtime, reviewsCount: Int?
    let platforms: [Platform]
    let genres, tags: [Genre]
    let descriptionRaw: String?

    enum CodingKeys: String, CodingKey {
        case name
        case backgroundImage = "background_image"
        case rating, playtime
        case reviewsCount = "reviews_count"
        case platforms, genres, tags
        case descriptionRaw = "description_raw"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
}

// MARK: - Platform
struct Platform: Codable {
    let platform: Genre?
}

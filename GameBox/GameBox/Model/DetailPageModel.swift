//
//  DetailPageModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 19.01.2023.
//

import Foundation

// MARK: - DetailPageModel
struct DetailPageModel: Codable {
    let id: Int?
    let name, description: String?
    let metacritic: Int?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop, playtime, ratingsCount: Int?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case id, name, description, metacritic, released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case playtime
        case ratingsCount = "ratings_count"
        case genres
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}


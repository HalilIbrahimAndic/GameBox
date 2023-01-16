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
    let results: [RAWGModel]?

}

// MARK: - Result
struct RAWGModel: Decodable {
    let id: Int?
    let name, released: String?
    let background_image: String?
    let rating: Double?
//    let metacritic: Int?
//    let platforms: [PlatformElement]?
//    let genres: [Genre]?

//    enum CodingKeys: String, CodingKey {
//        case id, name, released
//        case backgroundImage = "background_image"
//        case rating
//        case metacritic
//        case platforms
//        case genres
//    }
}

// MARK: - Genre
//struct Genre: Codable {
//    let id: Int?
//    let name: String?

//    enum CodingKeys: String, CodingKey {
//        case id, name
//    }
//}

// MARK: - PlatformElement
//struct PlatformElement: Codable {
//    let platform: PlatformPlatform?

//    enum CodingKeys: String, CodingKey {
//        case platform
//    }
//}

// MARK: - PlatformPlatform
//struct PlatformPlatform: Codable {
//    let id: Int?
//    let name: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//    }
//}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

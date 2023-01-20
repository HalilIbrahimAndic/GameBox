//
//  DetailCacheModel.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 20.01.2023.
//

import Foundation

struct DetailCacheModel{
    let id: Int
    let name: String
    let background_image: String
    let rating: Double
    let playtime: Int
    let reviews_count: Int
    let platform_name: String
    let genre_name: String
    let tag_name: String
    let description_raw: String
}

//struct DetailCacheModel {
//    let id: Int
//    let name: String
//    let background_image: String
//    let rating: Double
//    let playtime, reviews_count: Int
//    let platforms: [Platform2]
//    let genres, tags: [Genre2]
//    let description_raw: String
//    let platform_name: String
//    let tag_name: String
//    let genre_name: String
//}
//
//struct Genre2{
//    let name: String
//}
//
//struct Platform2 {
//    let platform: Genre2
//}

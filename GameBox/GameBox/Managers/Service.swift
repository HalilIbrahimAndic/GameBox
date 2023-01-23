//
//  Service.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 23.01.2023.
//

import Foundation

struct Service {
    
    static let apiKey = "?key=d04a8d582093458f9cc979cd66f2d71d"
    static let base = "https://api.rawg.io/api/"
    static let gamesBaseUrl = base + "games\(apiKey)"
    
    let baseURL = gamesBaseUrl
    
    func sortedAPI(_ choice: Int) -> String {
        switch choice {
        case 1:
            return baseURL + "&dates=2022-01-01,2023-01-31" //2022
        case 2:
            return baseURL + "&genres=5" //RPG
        case 3:
            return baseURL + "&tags=5" //Co-op
        case 4:
            return baseURL + "&platforms=5" //Mac-os
        case 0:
            return baseURL
        default:
            return baseURL
        }
    }
}

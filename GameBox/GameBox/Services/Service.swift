//
//  Service.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 23.01.2023.
//

import Foundation

final class Service {
    
    static let apiKey = "?key=d04a8d582093458f9cc979cd66f2d71d"
    static let base = "https://api.rawg.io/api/"
    let gamesBaseUrl = base + "games\(apiKey)"
    
    func sortedAPI(_ choice: Int) -> String {
        switch choice {
        case 1:
            return gamesBaseUrl + "&ordering=name"
        case 2:
            return gamesBaseUrl + "&ordering=rating"
        case 3:
            return gamesBaseUrl + "&dates=2022-01-01,2022-12-31"
        case 4:
            return gamesBaseUrl + "&platforms=5"
        case 5:
            return gamesBaseUrl
        default:
            return gamesBaseUrl
        }
    }
}

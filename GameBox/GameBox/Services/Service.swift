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
            print(baseURL + "&ordering=name")
            return baseURL + "&ordering=name"
        case 2:
            print(baseURL + "&ordering=rating")
            return baseURL + "&ordering=rating"
        case 3:
            print(baseURL + "&dates=2022-01-01,2022-12-31")
            return baseURL + "&dates=2022-01-01,2022-12-31"
        case 4:
            print(baseURL + "&platforms=5")
            return baseURL + "&platforms=5"
        case 5:
            print("serviste clear'a geldim.")
            return baseURL
        default:
            return baseURL
        }
    }
}

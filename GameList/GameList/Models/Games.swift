//
//  Game.swift
//  GameList
//
//  Created by Hümeyra Şahin on 6.03.2022.
//

import Foundation

struct Games: Codable{
    var results = [Game?]()
}

struct Game: Codable{
    let name: String?
    let id: Int?
    let released: String?
    let slug: String?
    let background_image: String?
    let rating: Double?
    
}

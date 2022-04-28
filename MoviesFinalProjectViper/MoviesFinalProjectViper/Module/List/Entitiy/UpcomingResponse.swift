//
//  UpcomingResponse.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 25.04.2022.
//

import Foundation

struct UpcomingResponse: Codable{
    let results: [UpcomingMovie]?
    
}

struct UpcomingMovie: Codable{
    let posterPath: String?
    let overview: String?
    let id: Int?
    let releaseDate: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey{
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

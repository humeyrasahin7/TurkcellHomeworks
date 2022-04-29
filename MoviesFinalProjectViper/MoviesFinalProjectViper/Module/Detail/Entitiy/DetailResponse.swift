//
//  DetailResponse.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 25.04.2022.
//

import Foundation

struct DetailResponse: Codable{
    
    let backdropPath: String?
    let imdbID: String?
    let id: Int?
    let overview: String?
    let voteAverage: Double?
    let title: String?
    let releaseDate: String?
    let originalTitle: String?
    
    enum CodingKeys: String, CodingKey{
        case overview, title, id
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case imdbID = "imdb_id"
        case backdropPath =  "backdrop_path"
        case originalTitle = "original_title"
    }
}



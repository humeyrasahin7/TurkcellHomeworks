//
//  SimilarMoviesResponse.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 25.04.2022.
//

import Foundation

struct SimilarMoviesResponse: Codable{
    let results: [SimilarMovie]?
}

struct SimilarMovie: Codable{
    
    let backdropPath: String?
    let id: Int?
    let title: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey{
        case id,title
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}

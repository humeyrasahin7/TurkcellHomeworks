//
//  SearchResultResponse.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 25.04.2022.
//

import Foundation

struct SearchResultResponse: Codable{
    let results: [MatchingMovie]?
}

struct MatchingMovie: Codable{
    let id: Int?
    let title: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey{
        case id, title
        case releaseDate = "release_date"
    }
}

//
//  NowPlayingResponse.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 24.04.2022.
//

import Foundation

//MARK: - MoviesResponse

struct NowPlayingResponse: Codable{
    let results: [NowPlayingMovie]?
}

struct NowPlayingMovie: Codable{
    let posterPath: String?
    let id: Int?
    let title: String?
    
    enum CodingKeys: String, CodingKey{
        case id, title
        case posterPath = "poster_path"
    }
}

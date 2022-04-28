//
//  ServiceManager.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 24.04.2022.
//

import Foundation

protocol MoviesServiceProtocol {
    
    func fetchNowPlayingMovies(completionHandler: @escaping (NowPlayingResult) -> ())
    func fetchUpcomingMovies(completionHandler: @escaping (UpcomingResult) -> ())
    func fetchDetails(sourceId: Int, completioonHandler: @escaping (DetailResult) -> ())
    func fetchSimilarMovies(sourceId: Int, completionHandler: @escaping (SimilarMoviesResult) -> ())
    func fetchSearchResults(query: String, completionHandler: @escaping (SearchResult) -> ())
}


typealias NowPlayingResult = Result<NowPlayingResponse, Error>
typealias UpcomingResult = Result<UpcomingResponse, Error>
typealias DetailResult  = Result<DetailResponse, Error>
typealias SimilarMoviesResult = Result<SimilarMoviesResponse, Error>
typealias SearchResult = Result<SearchResultResponse, Error>


struct MovieService: MoviesServiceProtocol{
    func fetchNowPlayingMovies(completionHandler: @escaping (NowPlayingResult) -> ()) {
        NetworkManager.shared.request(ServiceRouter.nowPlaying, decodeToType: NowPlayingResponse.self, completionHandler: completionHandler)
    }
    
    func fetchUpcomingMovies(completionHandler: @escaping (UpcomingResult) -> ()) {
        NetworkManager.shared.request(ServiceRouter.upcoming, decodeToType: UpcomingResponse.self, completionHandler: completionHandler)
    }
    
    func fetchDetails(sourceId: Int, completioonHandler: @escaping (DetailResult) -> ()) {
        NetworkManager.shared.request(ServiceRouter.detail(movieId: sourceId), decodeToType: DetailResponse.self, completionHandler: completioonHandler)
    }
    
    func fetchSimilarMovies(sourceId: Int, completionHandler: @escaping (SimilarMoviesResult) -> ()) {
        NetworkManager.shared.request(ServiceRouter.similar(movieId: sourceId), decodeToType: SimilarMoviesResponse.self, completionHandler: completionHandler)
    }
    
    func fetchSearchResults(query: String, completionHandler: @escaping (SearchResult) -> ()) {
        NetworkManager.shared.request(ServiceRouter.search(query: query), decodeToType: SearchResultResponse.self, completionHandler: completionHandler)
    }
    
    
}

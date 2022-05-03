//
//  MockInteractor.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 1.05.2022.
//

import Foundation
@testable import MoviesFinalProjectViper

final class MockListInteractor: ListInteractorProtocol{
    
    var invokedFetchNowPlayingMovie = false
    var invokedFetchNowPlayingMoviesCount = 0
    
    var invokedFetchUpcomingMovie = false
    var invokedFetchUpcomingMovieCount = 0
    
    
    func fetchNowPlayingMovies() {
        self.invokedFetchNowPlayingMovie = true
        self.invokedFetchNowPlayingMoviesCount += 1
    }
    
    func fetchUpcomingMovies() {
        self.invokedFetchUpcomingMovie = true
        self.invokedFetchUpcomingMovieCount += 1
    }
    
    
}


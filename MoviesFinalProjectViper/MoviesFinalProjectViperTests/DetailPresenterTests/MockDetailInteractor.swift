//
//  MockDetailInteractor.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 3.05.2022.
//

import Foundation
@testable import MoviesFinalProjectViper

final class MockDetailInteractor: DetailInteractorProtocol{
    
    var isInvokedFetchMovieDetail = false
    var isInvokedFetchSimilarMovies = false
    var invokedFetchSimilarMovieCount = 0
    
    func fetchDetail(sourceId: Int) {
        self.isInvokedFetchMovieDetail = true
    }
    
    func fetchSimilarMovies(sourceId: Int) {
        self.isInvokedFetchSimilarMovies = true
        invokedFetchSimilarMovieCount += 1
    }
    
    
}

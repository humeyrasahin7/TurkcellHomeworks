//
//  DetailInteractor.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject{
    func fetchDetail(sourceId: Int)
    func fetchSimilarMovies(sourceId: Int)
}

protocol DetailInteractorOutputProtocol{
    func fetchDetailOutput(result: DetailResult)
    func fetchSimilarMoviesOutput(result: SimilarMoviesResult)
}

fileprivate var moviesService: MoviesServiceProtocol = MovieService()

final class DetailInteractor{
    var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol{
    func fetchDetail(sourceId: Int) {
        moviesService.fetchDetails(sourceId: sourceId) { [weak self] result in
            guard let self = self else {return}
            self.output?.fetchDetailOutput(result: result)
        }
    }
    
    func fetchSimilarMovies(sourceId: Int) {
        moviesService.fetchSimilarMovies(sourceId: sourceId) { [weak self] result in
            guard let self = self else {return}
            self.output?.fetchSimilarMoviesOutput(result: result)
        }
    }
    
    
}

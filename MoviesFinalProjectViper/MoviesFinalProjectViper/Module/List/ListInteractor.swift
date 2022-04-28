//
//  ListInteractor.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import Foundation

protocol ListInteractorProtocol: AnyObject{
    func fetchNowPlayingMovies()
    func fetchUpcomingMovies()
}

protocol ListInteractorOutputProtocol: AnyObject{
    func fetchNowPlayingMoviesOutput(result: NowPlayingResult)
    func fetchUpcomingMoviesOutput(result: UpcomingResult)
}

fileprivate var moviesService: MoviesServiceProtocol = MovieService()

final class ListInteractor{
    var output: ListInteractorOutputProtocol?
}

extension ListInteractor: ListInteractorProtocol{
    
    func fetchNowPlayingMovies() {
        moviesService.fetchNowPlayingMovies { [weak self] result in
            guard let self = self else {return}
            self.output?.fetchNowPlayingMoviesOutput(result: result)
        }
    }
    
    func fetchUpcomingMovies() {
        moviesService.fetchUpcomingMovies { [weak self] result in
            guard let self = self else {return}
            self.output?.fetchUpcomingMoviesOutput(result: result)
        }
    }
    
     
}

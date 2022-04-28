//
//  SearchInteractor.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import Foundation

protocol SearchInteractorProtocol: AnyObject{
    func fetchSearchResult(query: String)
}

protocol SearchInteractorOutputProtocol{
    func fetchSearchResultOutput(result: SearchResult)
}

fileprivate var moviesService: MoviesServiceProtocol = MovieService()

final class SearchInteractor{
    var output: SearchInteractorOutputProtocol?
}

extension SearchInteractor: SearchInteractorProtocol{
    func fetchSearchResult(query: String) {
        moviesService.fetchSearchResults(query: query) { [weak self] result in
            guard let self = self else {return}
            self.output?.fetchSearchResultOutput(result: result)
        }
    }
    
    
}

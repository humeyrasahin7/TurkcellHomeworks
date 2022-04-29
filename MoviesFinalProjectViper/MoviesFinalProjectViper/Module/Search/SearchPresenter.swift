//
//  SearchPresenter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import Foundation

protocol SearchPresenterProtocol{
    func viewDidLoad()
    func numberOfItems() -> Int
    func didSelectRowAt(index: Int)
    func movie(_ index: Int) -> MatchingMovie?
}

final class SearchPresenter{
    
}

extension SearchPresenter: SearchPresenterProtocol{
    func viewDidLoad() {
        ///
    }
    
    func numberOfItems() -> Int {
        return 0
    }
    
    func didSelectRowAt(index: Int) {
        //
    }
    
    func movie(_ index: Int) -> MatchingMovie? {
        return nil
    }
    
    
}

extension SearchPresenter: SearchInteractorOutputProtocol{
    func fetchSearchResultOutput(result: SearchResult) {
        switch result{
        case .success(let searchResult):
            break
        case .failure(let error):
            print(error)
            
        }
    }
    
    
}

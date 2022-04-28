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
        <#code#>
    }
    
    func numberOfItems() -> Int {
        <#code#>
    }
    
    func didSelectRowAt(index: Int) {
        <#code#>
    }
    
    func movie(_ index: Int) -> MatchingMovie? {
        <#code#>
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

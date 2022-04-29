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
    
    private var movies: [MatchingMovie] = []
    unowned var view: SearchViewControllerProtocol?
    let router: SearchRouterProtocol!
    let interactor: SearchInteractorProtocol!
    let query: String
    init(view: SearchViewControllerProtocol, router: SearchRouterProtocol, interactor: SearchInteractorProtocol, query: String){
        self.view = view
        self.router = router
        self.interactor = interactor
        self.query = query
    }
}

extension SearchPresenter: SearchPresenterProtocol{
    func viewDidLoad() {
        view?.setupTableView()
        fetchSearchResults()
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func didSelectRowAt(index: Int) {
        guard let movie = movie(index) else {return}
        router.navigate(.detail(movieID: movie.id!))
    }
    
    func movie(_ index: Int) -> MatchingMovie? {
        return movies[safe: index]
    }
    
    private func fetchSearchResults(){
        interactor.fetchSearchResult(query: query)
    }
    
}

extension SearchPresenter: SearchInteractorOutputProtocol{
    func fetchSearchResultOutput(result: SearchResult) {
        switch result{
        case .success(let searchResult):
            movies = searchResult.results ?? []
            view?.reloadData()
        case .failure(let error):
            print(error)
            
        }
    }
    
    
}

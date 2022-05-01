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
    func fetchSearchResults(query: String)
    func clearTableView()
}

final class SearchPresenter{
    
    private var movies: [MatchingMovie] = []
    unowned var view: SearchViewControllerProtocol?
    let router: SearchRouterProtocol!
    let interactor: SearchInteractorProtocol!
    
        
    init(view: SearchViewControllerProtocol, router: SearchRouterProtocol, interactor: SearchInteractorProtocol){
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchPresenterProtocol{
    func clearTableView() {
        movies = []
        view?.reloadData()
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        
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
    
    func fetchSearchResults(query: String){
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

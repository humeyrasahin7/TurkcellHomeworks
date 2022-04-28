//
//  DetailPresenter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import Foundation

protocol DetailPresenterProtocol{
    func viewDidLoad()
    func numberOfItems() -> Int
    func similarMovie(_ index: Int) -> SimilarMovie?
    func didSelectItemAt(index: Int)
    func addGestureRecognizer()
    func addToFavs()
}

final class DetailPresenter{
    
    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol!
    let interactor: DetailInteractorProtocol!
    
    let movieID: Int!
    
    private var movieDetail: DetailResponse!
    private var similarMovies = [SimilarMovie]()
    
    init(view: DetailViewControllerProtocol, router: DetailRouterProtocol, interactor: DetailInteractorProtocol, movieID: Int){
        self.view = view
        self.router = router
        self.interactor = interactor
        self.movieID = movieID
    }
}

extension DetailPresenter: DetailPresenterProtocol{
    func viewDidLoad() {
        interactor.fetchDetail(sourceId: self.movieID)
        interactor.fetchSimilarMovies(sourceId: self.movieID)
        view?.setupCollectionView()
        
    }
    
    func numberOfItems() -> Int {
        return similarMovies.count
    }
    
    func similarMovie(_ index: Int) -> SimilarMovie? {
        return similarMovies[safe: index]
    }
    
    func didSelectItemAt(index: Int) {
        var movieID: Int!
        guard let movie = similarMovie(index) else {return}
        movieID = movie.id
        router.navigate(.toDetail(movieID: movieID))
                        
    }
    
    func addGestureRecognizer() {
        
    }
    
    func addToFavs() {
        
    }
    
    
}

extension DetailPresenter: DetailInteractorOutputProtocol{
    func fetchDetailOutput(result: DetailResult) {
        switch result{
        case .success(let detailResult):
            movieDetail = detailResult
            view?.addTabGestureRecog()
            view?.setTitle("\(movieDetail.title ?? "") - \(movieDetail.originalTitle ?? "")")
            view?.setDescription(movieDetail.overview ?? "")
            view?.setPoster("https://image.tmdb.org/t/p/original\(movieDetail.backdropPath ?? "")")
            view?.setRatingLabel(movieDetail.voteAverage ?? 0.0)
            view?.setReleadeDate(movieDetail.releaseDate ?? "")
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchSimilarMoviesOutput(result: SimilarMoviesResult) {
        switch result{
        case .success(let similarMoviesResult):
            similarMovies = similarMoviesResult.results ?? []
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
    
}

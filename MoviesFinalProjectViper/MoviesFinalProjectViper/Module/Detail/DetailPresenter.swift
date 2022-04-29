//
//  DetailPresenter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import Foundation

protocol DetailPresenterProtocol{
    func viewDidLoad()
    func viewWillAppear(_ favMovies: [Int])

    func numberOfItems() -> Int
    func similarMovie(_ index: Int) -> SimilarMovie?
    func didSelectItemAt(index: Int)
    func addGestureRecognizer()
    func addToFavs() -> [Int]
}

final class DetailPresenter{
    
    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol!
    let interactor: DetailInteractorProtocol!
    
    let movieID: Int!
    var favMovies = [Int]()
    
    
    private var isFav: Bool!
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
    
    func viewWillAppear(_ movies: [Int]){
        favMovies = movies
  
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
        guard let imdbID = movieDetail.imdbID else { return  }
        router.navigate(.toImbdb(imdbID: imdbID))
    }
    
    func addToFavs() -> [Int] {
        if favMovies.contains(movieDetail.id!){
            view?.setButtonImg(false)
            favMovies.remove(at: favMovies.firstIndex(of: movieDetail.id!)!)
        } else {
            favMovies.append(movieDetail.id!)
            view?.setButtonImg(true)
        }
        return favMovies
    }
    
    
}

extension DetailPresenter: DetailInteractorOutputProtocol{
    func fetchDetailOutput(result: DetailResult) {
        switch result{
        case .success(let detailResult):
            movieDetail = detailResult
            let date = dateFormatter(movieDetail.releaseDate!, format: "dd.MM.yyyy")
            view?.setTitle("\(movieDetail.title ?? "")")
            view?.setDescription(movieDetail.overview ?? "")
            view?.setPoster("https://image.tmdb.org/t/p/original\(movieDetail.backdropPath ?? "")")
            view?.setRatingLabel(movieDetail.voteAverage ?? 0.0)
            view?.setReleaseDate(date)
            view?.addTabGestureRecog()
            
            if favMovies.contains(movieDetail.id!){
                view?.setButtonImg(true)
            } else {
                view?.setButtonImg(false)
            }
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

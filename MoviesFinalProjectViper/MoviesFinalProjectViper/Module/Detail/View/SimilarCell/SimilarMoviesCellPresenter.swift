//
//  SimilarMoviesCellPresenter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import Foundation

protocol SimilarMoviesCellPresenterProtocol: AnyObject{
    func load()
}

final class SimilarMoviesCellPresenter{
    weak var view: SimilarMoviesCellProtocol?
    private let movie: SimilarMovie
    
    init(view: SimilarMoviesCellProtocol, movie: SimilarMovie){
        self.view = view
        self.movie = movie
    }
}

extension SimilarMoviesCellPresenter: SimilarMoviesCellPresenterProtocol{
    func load() {
        view?.setPoster("https://image.tmdb.org/t/p/original\(movie.backdropPath ?? "")")
        view?.setTitle(movie.title ?? "")
        view?.setReleaseYear(movie.releaseDate ?? "")
        view?.configCell()
    }
    
}


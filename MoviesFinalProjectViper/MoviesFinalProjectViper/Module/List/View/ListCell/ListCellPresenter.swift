//
//  ListCellPresenter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import Foundation
 
protocol ListCellPresenterProtocol: AnyObject{
    func load()
}

final class ListCellPresenter{
    
    weak var view: ListCollectionViewCellProtocol?
    private let movie: UpcomingMovie
    
    init(view: ListCollectionViewCellProtocol, movie: UpcomingMovie){
        self.view = view
        self.movie = movie
    }
}

extension ListCellPresenter: ListCellPresenterProtocol{
    func load() {
        view?.setTitle(movie.title ?? "")
        view?.setDescription(movie.overview ?? "")
        view?.setPoster( "https://image.tmdb.org/t/p/original\(movie.posterPath ?? "")")
        view?.setReleaseDate(movie.releaseDate ?? "")
        view?.configCell()
    }
    
}

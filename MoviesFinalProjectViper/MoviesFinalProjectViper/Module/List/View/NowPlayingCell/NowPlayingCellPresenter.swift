//
//  NowPlayingCellPresenter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import Foundation

protocol NowPlayingCellPresenterProtocol: AnyObject{
    func load()
}

final class NowPlayingCellPresenter{
    
    weak var view: NowPlayingCollectionViewCellProtocol?
    private let movie: NowPlayingMovie
    
    init(view: NowPlayingCollectionViewCellProtocol, movie: NowPlayingMovie){
        self.view = view
        self.movie = movie
    }
}

extension NowPlayingCellPresenter: NowPlayingCellPresenterProtocol{
    func load() {
        view?.setTitle(movie.title ?? "")
        view?.setPoster( "https://image.tmdb.org/t/p/original\(movie.posterPath ?? "")")
        view?.configCell()
    }
    
}

//
//  SearchTableViewCellPresenter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 29.04.2022.
//

import Foundation

protocol SearchTableViewCellPresenterProtocol: AnyObject{
    func load()
}

final class SearchTableViewCellPresenter{
    weak var view: SearchTableViewCellProtocol?
    private let movie: MatchingMovie
    
    init(view: SearchTableViewCellProtocol, movie: MatchingMovie){
        self.view = view
        self.movie = movie
    }
}

extension SearchTableViewCellPresenter: SearchTableViewCellPresenterProtocol{
    func load() {
        let year = dateFormatterGetYear(movie.releaseDate ?? "", format: "yyyy")
        view?.setTitle("\(movie.title ?? "") (\(year))")
    }
    
    
}

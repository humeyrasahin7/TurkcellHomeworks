//
//  DetailRouter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import Foundation
import UIKit

protocol DetailRouterProtocol: AnyObject{
    func navigate(_ routes: DetailRoutes)
}

final class DetailRouter{
    weak var viewController: DetailViewController?
    static func createModules(movieID: Int) -> DetailViewController{
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, router: router, interactor: interactor, movieID: movieID)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

enum DetailRoutes{
    case toDetail(movieID: Int)
    case toImbdb(imdbID: String)
}

extension DetailRouter: DetailRouterProtocol{
    func navigate(_ routes: DetailRoutes) {
        switch routes {
        case .toDetail(let movieID):
            let detailVC = DetailRouter.createModules(movieID: movieID)
            self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
        case .toImbdb(let imdbID):
            if let url = URL(string: "https://www.imdb.com/title/\(imdbID)") {
                UIApplication.shared.open(url)
            }
            
        }
    }
}



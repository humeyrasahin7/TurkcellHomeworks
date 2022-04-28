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
}

extension DetailRouter: DetailRouterProtocol{
    func navigate(_ routes: DetailRoutes) {
        switch routes {
        case .toDetail(let movieID):
            guard let window = viewController?.view.window else {return}
            let detailVC = DetailRouter.createModules(movieID: movieID)
            let navigationController = UINavigationController(rootViewController: detailVC)
            window.rootViewController = navigationController
        }
    }
}



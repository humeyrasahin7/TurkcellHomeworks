//
//  SearchRouter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import Foundation

protocol SearchRouterProtocol: AnyObject{
    func navigate(_ route: SearchRoutes)
}

enum SearchRoutes{
    case detail(movieID: Int)
}

final class SearchRouter{
    weak var viewController: SearchViewController?
    
    static func createModules(query: String) -> SearchViewController{
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, router: router, interactor: interactor, query: query)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SearchRouter: SearchRouterProtocol{
    func navigate(_ route: SearchRoutes) {
        switch route {
        case .detail(let movieID):
            let detailVC = DetailRouter.createModules(movieID: movieID)
            self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
}

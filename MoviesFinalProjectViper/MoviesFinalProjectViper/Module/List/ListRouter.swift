//
//  ListRouter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import Foundation
import UIKit

protocol ListRouterProtocol: AnyObject{
    func navigate(_ routes: ListRoutes)
}

enum ListRoutes{
    case detail(movieID: Int)
}

final class ListRouter{
    weak var viewController: ListViewController?
    static func createModules() -> ListViewController{
        let view = ListViewController()
        let interactor = ListInteractor()
        let router = ListRouter()
        let presenter = ListPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension ListRouter: ListRouterProtocol{
    func navigate(_ routes: ListRoutes) {
        switch routes {
        case .detail(let movieID):
            guard let window = viewController?.view.window else {return}
            let detailVC = DetailRouter.createModules(movieID: movieID)
            
            let navigationController = UINavigationController(rootViewController: detailVC)
            window.rootViewController = navigationController
        }
    
        
    }
    
    
}

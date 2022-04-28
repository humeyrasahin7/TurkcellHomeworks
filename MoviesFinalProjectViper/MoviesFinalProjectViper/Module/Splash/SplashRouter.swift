//
//  SplashRouter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import Foundation
import UIKit


protocol SplashRouterProtocol: AnyObject{
    func navigate(_ route: SplashRoutes)
}


enum SplashRoutes{
    case listScreen
}

final class SplashRouter{
    weak var viewController: SplashViewController?
    static func createModules() -> SplashViewController{
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SplashRouter: SplashRouterProtocol{
    func navigate(_ route: SplashRoutes) {
        switch route {
        case .listScreen:
            guard let window = viewController?.view.window else {return}
            let listVC = ListRouter.createModules()
            let navigationController = UINavigationController(rootViewController: listVC)
            window.rootViewController = navigationController
        }
    }
    
    
}

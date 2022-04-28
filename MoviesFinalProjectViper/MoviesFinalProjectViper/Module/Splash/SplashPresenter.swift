//
//  SplashPresenter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject{
    func viewDidAppear()
}

final class SplashPresenter: SplashPresenterProtocol{
    unowned var view: SplashViewControllerProtocol!
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!
    
    init(view: SplashViewControllerProtocol , router: SplashRouterProtocol, interactor: SplashInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
    
}

extension SplashPresenter: SplashInteractorOutputProtocol{
    func internetConnection(status: Bool) {
        if status{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.router.navigate(.listScreen)
            }
        } else {
            view.noInternetConnection()
        }
    }
    
}

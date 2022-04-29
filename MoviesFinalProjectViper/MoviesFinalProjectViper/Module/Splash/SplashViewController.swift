//
//  SplashViewController.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 27.04.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

class SplashViewController: BaseViewController {

    var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }


}


extension SplashViewController: SplashViewControllerProtocol {
    
    func noInternetConnection() {
       
       showAlert(title: "Error", message: "No Internet Connection, Please check your connection")
    }
}

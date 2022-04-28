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

        // Do any additional setup after loading the view.
        presenter.viewDidAppear()
    }



}


extension SplashViewController: SplashViewControllerProtocol {
    
    func noInternetConnection() {
        /*
        let vc = SplashViewController()
        vc.present(showAlert(title: "Error", message: "No Internet Connection, Please check your connection"), animated: true)*/
    }
}

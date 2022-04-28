//
//  BaseViewController.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String, message: String) -> UIAlertController{
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return ac
    }

}

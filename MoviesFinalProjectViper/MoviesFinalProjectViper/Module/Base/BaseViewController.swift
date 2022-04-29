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
    
    func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default){ (action) in
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            Thread.sleep(forTimeInterval: 1)
            exit(0)
        })
        self.present(ac, animated: true)
    }

}

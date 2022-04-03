//
//  SplashViewController.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 2.04.2022.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(dismissSplashScreen), userInfo: nil, repeats: false)
    }

    @objc func dismissSplashScreen(){
        performSegue(withIdentifier: "toUserVC", sender: nil)
      
    }
}


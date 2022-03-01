//
//  TabbarViewController.swift
//  week07
//
//  Created by Hümeyra Şahin on 28.02.2022.
//

import UIKit

class TabbarViewController: UITabBarController {
   override func viewDidLoad() {
        super.viewDidLoad()
       
        let home = ViewController()
        let map = MapViewController()
       self.setViewControllers([home,map], animated: false)
    }
    
    
}

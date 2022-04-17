//
//  CustomAllertViewController.swift
//  Challenge
//
//  Created by Hümeyra Şahin on 16.04.2022.
//

import UIKit

class CustomAlertViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var allertTitle: UILabel!
    @IBOutlet weak var allertDetail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.configView()
        
    }
    
    func createCustomAC(title: String, detail: String){
        self.allertTitle.text = title
        self.allertDetail.text = detail
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.removeFromParent()
            self.view.removeFromSuperview()
            self.modalTransitionStyle = .crossDissolve
        }, completion: nil)
    }
    
  

}




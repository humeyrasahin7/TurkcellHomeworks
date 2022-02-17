//
//  CustomAlertViewController.swift
//  BusTicket
//
//  Created by Hümeyra Şahin on 17.02.2022.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.layer.cornerRadius = 25
    }
    
    func createCustomAC(title: String, message: String){
        self.titleLabel.text = title
        self.messageLabel.text = message
    }
    
    @IBAction func gotItTapped(_ sender: Any) {
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.removeFromParent()
            self.view.removeFromSuperview()
            self.modalTransitionStyle = .crossDissolve
        }, completion: nil)
    }
    
}

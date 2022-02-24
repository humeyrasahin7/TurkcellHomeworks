//
//  OnboardingViewController.swift
//  BusTicket
//
//  Created by Hümeyra Şahin on 12.02.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var titleBackgound: UIView!
    
    @IBOutlet weak var detailBackground: UIView!
    var isLaunchedBefore: Bool!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.adjustsFontSizeToFitWidth = true
        titleBackgound.layer.cornerRadius = 25
        detailBackground.layer.cornerRadius = 25
        
        
    }

    @IBAction func goButtonTapped(_ sender: Any) {
        isLaunchedBefore = true
        UserDefaults.standard.set(isLaunchedBefore, forKey: "isLaunched")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainVC")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
}

//
//  UIViewControllerExtension.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 7.04.2022.
//

import Foundation
import UIKit

extension UIViewController{
    func customizeNavigationBackButton(title: String){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Noteworthy-Bold", size: 16)!], for: .normal)
    }
}

//
//  LoadingShowable.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import UIKit

protocol LoadingShowable where Self: UIViewController {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    func showLoading() {
        LoadingView.shared.startLoading()
    }

    func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}

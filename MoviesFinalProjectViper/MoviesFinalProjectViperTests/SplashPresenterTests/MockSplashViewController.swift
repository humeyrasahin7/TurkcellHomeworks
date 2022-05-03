//
//  MockSplashViewController.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 3.05.2022.
//

import Foundation
@testable import MoviesFinalProjectViper

final class MockSplashViewController: SplashViewControllerProtocol{
    
    var isNoInternetInvoked = false
    
    func noInternetConnection() {
        isNoInternetInvoked = true
    }
    
    
}

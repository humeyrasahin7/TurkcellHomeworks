//
//  MockSplashInteractor.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 3.05.2022.
//

import Foundation
@testable import MoviesFinalProjectViper

final class MockSplashInteractor: SplashInteractorProtocol{
    
    var invokedInternetStatus = false
    
    func checkInternetConnection() {
        invokedInternetStatus = true
    }
    
    
}

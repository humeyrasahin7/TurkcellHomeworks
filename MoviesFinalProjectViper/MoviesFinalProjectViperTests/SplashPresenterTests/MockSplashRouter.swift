//
//  MockSplashRouter.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 3.05.2022.
//

import Foundation
@testable import MoviesFinalProjectViper


final class MockSplashRouter: SplashRouterProtocol{
    var isNavigateToDetailInvoked = false
    func navigate(_ route: SplashRoutes) {
        isNavigateToDetailInvoked = true
    }
    
}


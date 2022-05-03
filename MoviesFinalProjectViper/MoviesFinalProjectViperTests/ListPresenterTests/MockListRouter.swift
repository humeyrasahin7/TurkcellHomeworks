//
//  MockRouter.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 1.05.2022.
//

import Foundation
@testable import MoviesFinalProjectViper

final class MockListRouter: ListRouterProtocol{
    
    var isNavigateToDetailInvoked = false
    var isInvokedDidSelectItemAt = false
    
    func navigate(_ routes: ListRoutes) {
        isNavigateToDetailInvoked = true
        isInvokedDidSelectItemAt = true
    }
    
}

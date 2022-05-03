//
//  MockDetailRouter.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 3.05.2022.
//

import Foundation
@testable import MoviesFinalProjectViper

final class MockDetailRouter: DetailRouterProtocol{
    
    var isNavigateToSimilarDetailsInvoked = false
    var isInvokedDidSelectItemAt = false
    
    func navigate(_ routes: DetailRoutes) {
        isNavigateToSimilarDetailsInvoked = true
        isInvokedDidSelectItemAt = true
    }
    
    
}

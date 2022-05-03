//
//  MockViewController.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 1.05.2022.
//

import Foundation
@testable import MoviesFinalProjectViper

final class MockListViewController: ListViewControllerProtocol{
   
    var isInvokedReloadData = false
    var isInvokedSetupCollectionView = false
    var isInvokedSetupPageController = false
    var isInvokedSetSelectorFunc = false
    var isInvokedSetTimerSelectorFunc = false
    var isInvokedSetSearchController = false

    func reloadData() {
        isInvokedReloadData = true
    }
    
    func setupCollectionView() {
        isInvokedSetupCollectionView = true
    }
    
    func setupPageController() {
        isInvokedSetupPageController = true
    }
    
    func setSelectorFunc() {
        isInvokedSetSelectorFunc = true
    }
    
    func setTimerSelectorFunc() {
        isInvokedSetTimerSelectorFunc = true
    }
    
    func setSearchController(vc: SearchViewController) {
        isInvokedSetSearchController = true
    }
    
    
}

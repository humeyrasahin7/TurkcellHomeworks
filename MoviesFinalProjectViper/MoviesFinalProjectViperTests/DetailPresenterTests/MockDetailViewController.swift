//
//  MockDetailViewController.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 3.05.2022.
//

import Foundation
@testable import MoviesFinalProjectViper

final class MockDetailViewController: DetailViewControllerProtocol{
    
    var isInvokedReloadData = false
    var isInvokedSetupCollectionView = false
    var isInvokedAddTappGestureRecog = false
    var isInvokedAdd = false
    
    func reloadData() {
        isInvokedReloadData = true
        setupCollectionView()
        addTabGestureRecog()
    }
    
    func setupCollectionView() {
        isInvokedSetupCollectionView = true
    }
    
    func addTabGestureRecog() {
        isInvokedAddTappGestureRecog = true
    }
    
    func setSelectorFunc() {}
    
    func addToFavs() {}
    
    func setButtonImg(_ isFav: Bool) {
        isInvokedAdd = true
    }
    
    func setPoster(_ imagePath: String) {}
    
    func setTitle(_ title: String) {}
    
    func setDescription(_ description: String) {}
    
    func setRatingLabel(_ rating: Double) { }
    
    func setReleaseDate(_ date: String) {}
    
    
}

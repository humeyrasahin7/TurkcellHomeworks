//
//  PostDetailsViewModel.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 3.04.2022.
//

import Foundation


protocol PostDetailsViewModelProtocol{
    func calculateCellSize(collectionViewHeight: Double, collectionViewWidht: Double) -> (width: Double, height: Double)
}


final class PostDetailsViewModel: PostDetailsViewModelProtocol{
    func calculateCellSize(collectionViewHeight: Double, collectionViewWidht: Double) -> (width: Double, height: Double) {
        let cellWidht = collectionViewWidht * 0.95
        let cellHeight = collectionViewHeight * 0.5
        return (cellWidht, cellHeight)
    }
    
    
    
}

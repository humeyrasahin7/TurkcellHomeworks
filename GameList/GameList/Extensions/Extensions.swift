//
//  ListCollectionViewExtension.swift
//  GameList
//
//  Created by Hümeyra Şahin on 7.03.2022.
//

import Foundation
import UIKit


var imageToReturn = UIImage()
extension UIViewController {
    
    func load(url: URL, complete: @escaping (UIImage?) -> Void){
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        complete(image)
                    }
                }
            }
        }
    }
    
}
extension GameListViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == bannerCollectionView){
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
        }
        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height * 0.25)
    }
}



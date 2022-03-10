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
    
    func openDetail(detailRequest: GameDetailRequest){
        var details: Detail?
        detailRequest.getDetail { [self] result in
            switch result{
                
            case .success(let detail):
                details = detail
                DispatchQueue.main.async {
                    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else {return}
                    vc.detail = details
                    vc.title = "Details"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
               
            case .failure(let error):
                print(error.localizedDescription)
    
            }
        }
    }
    
}
extension GameListViewController: UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (collectionView == bannerCollectionView){
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
        }
        if isFiltering{
            if filteredGames.count == 0{
                return CGSize(width: gameListStackView.frame.width , height: gameListStackView.frame.height )
            }
            return CGSize(width: gameListStackView.frame.width * 0.95, height: gameListStackView.frame.height * 0.2 )
        } else {
            return myFirstSize
        }
        
    }
}



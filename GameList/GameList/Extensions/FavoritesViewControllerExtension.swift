//
//  FavoritesViewControllerExtension.swift
//  GameList
//
//  Created by Hümeyra Şahin on 11.03.2022.
//

import Foundation
import UIKit

//MARK: Collection View Delegate, Data Source
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favoriteGames.count == 0{
            return 1
        }
        return favoriteGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if favoriteGames.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! NoDataCollectionViewCell
            return cell
        }
        
        let game = favoriteGames[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameInformationCollectionViewCell
        cell.image.image = downLoadedImageList[(game.id)!]
        cell.nameLabel.text = game.name
        cell.rateAndDateLabel.text = "\((game.rating)!) - \((game.released)!)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = favoriteGames[indexPath.row]
        let detailRequest = GameDetailRequest(slug: (game.slug!))
        openDetail(detailRequest: detailRequest)
    }
}

//MARK: Flow Layout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if favoriteGames.count == 0{
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
        }
        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height * 0.15)
    }
}


//MARK: Function
extension FavoritesViewController{
    
    func updateFavs(){
        var favs = [Game]()
        for result in games.results{
            if DetailViewController.favoriteGames.contains((result?.id)!){
                
                favs.append(result!)
                
            }
        }
        favoriteGames = favs
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
}

//
//  GameListViewControllerExtension.swift
//  GameList
//
//  Created by Hümeyra Şahin on 11.03.2022.
//

import Foundation
import UIKit

extension GameListViewController{
    func initCollectionView(collectionView: UICollectionView){
        collectionView.dataSource = self
        collectionView.delegate = self
        if collectionView == bannerCollectionView{
            collectionView.register(UINib(nibName: "BannerCell", bundle: nil), forCellWithReuseIdentifier: "bannerCell")
        } else{
            
            collectionView.register(UINib(nibName: "GameInformationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "gameCell")
            collectionView.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
}

//MARK: Flow Delegate

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

//MARK: SearchBar Delegate

extension GameListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isFiltering = false
            self.collectionView.reloadData()
        } else if searchText.count >= 3 {
            filteredGames = games.results.filter({ (game: Game!) -> Bool in
                return (game.name?.lowercased().contains(searchText.lowercased()))!
            })
            isFiltering = true
            self.collectionView.reloadData()
        }
        bannerStackView.isHidden = isFiltering
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}

//MARK: CollectionView Delegate and Datasource

extension GameListViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == bannerCollectionView){
            
            if downLoadedImageList.count > 3{
                rowCount = 3
            } else {
                rowCount = downLoadedImageList.count
            }
            return rowCount
        }
        
        if isFiltering{
            if filteredGames.count == 0{
                return 1
            } else {
                return filteredGames.count
            }
        }
        
        return downLoadedImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = games.results[indexPath.row]
        let detailRequest = GameDetailRequest(slug: (game?.slug!)!)
        openDetail(detailRequest: detailRequest)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let game : Game!
        if (collectionView == bannerCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCell
            game = games.results[indexPath.row]
            cell.bannerImage.image = downLoadedImageList[(game?.id)!]
            return cell
        }
        
        if isFiltering{
            if filteredGames.count == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! NoDataCollectionViewCell
                return cell
            } else {
                game = filteredGames[indexPath.row]
            }
        } else {
            game = games.results[indexPath.row]
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameInformationCollectionViewCell
        
        cell.image.image = downLoadedImageList[(game?.id)!]
        cell.nameLabel.text = game?.name
        cell.rateAndDateLabel.text = "\((game?.rating)!) - \((game?.released)!)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bannerCollectionView{
            let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let horizontalCenter = width / 2
            pageController.currentPage = Int(offSet + horizontalCenter) / Int(width)
        }
    }
}

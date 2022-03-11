//
//  FavoritesViewController.swift
//  GameList
//
//  Created by Hümeyra Şahin on 6.03.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var downLoadedImageList = [Int:UIImage]()
    var favoriteGames = [Game]()
    var games = Games(){
        didSet{
            DispatchQueue.main.async {
                
                for result in self.games.results{
                    let urlString = result?.background_image
                    self.load(url: URL(string: (urlString)!)! , complete: { image in
                       
                        self.downLoadedImageList[(result?.id)!] = image
                        self.collectionView.reloadData()
                        
                    })
                }
            }
        }
    }
    
    let gameRequest = GameListRequest()
    var detail: Detail?
    
    //MARK: View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GameInformationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "gameCell")
        
        gameRequest.getGames { result in
            
            switch result{
            case .success(let games):
                self.games = games
                self.updateFavs()
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    //MARK: View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       updateFavs()
    }
  
}


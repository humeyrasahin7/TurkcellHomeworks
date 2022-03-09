//
//  FavoritesViewController.swift
//  GameList
//
//  Created by Hümeyra Şahin on 6.03.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var downLoadedImageList = [Int:UIImage]()
    private var favoriteGames = [Game]()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       updateFavs()
    }
    
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

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteGames.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

extension FavoritesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height * 0.2)
    }
}

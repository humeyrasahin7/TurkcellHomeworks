//
//  GameListViewController.swift
//  GameList
//
//  Created by Hümeyra Şahin on 6.03.2022.
//

import UIKit

class GameListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var gameListStackView: UICollectionView!
    @IBOutlet weak var bannerStackView: UIStackView!
    
    var downLoadedImageList = [Int:UIImage]()
    var currentPageIndex = 0
    var image = UIImage()
    var filteredGames = [Game?]()
    var isFiltering = false
    var myFirstSize = CGSize()
    var rowCount = 0
    
    var games = Games(){
        didSet{
            DispatchQueue.main.async {
                
                for result in self.games.results{
                    let urlString = result?.background_image
                                        
                    self.load(url: URL(string: (urlString)!)! , complete: { image in
                       
                        self.downLoadedImageList[(result?.id)!] = image
                        self.collectionView.reloadData()
                        self.bannerCollectionView.reloadData()
                        
                    })
                }
              //  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.imageChange), userInfo: nil, repeats: true)
                self.pageController.addTarget(self, action: #selector(self.pageControlValueChanged(_:)), for: .valueChanged)
            }
        }
    }
    
    
    
    
    let gameRequest = GameListRequest()
    var detail: Detail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailViewController.favoriteGames = DetailViewController.userDefaults.value(forKey: "favGames") as? [Int] ?? [Int]()
        
        initCollectionView(collectionView: collectionView)
        initCollectionView(collectionView: bannerCollectionView)
        myFirstSize = CGSize(width: view.frame.width * 0.95, height: gameListStackView.frame.height * 0.22)
        
        searchBar.delegate = self
        
        gameRequest.getGames { result in
            
            switch result{
            case .success(let games):
                self.games = games
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        hideKeyboardWhenTappedAround()
    }
    
    
    @objc func imageChange(_ sender: UIPageControl){
        
        if currentPageIndex < 2{
            currentPageIndex += 1
        } else {
            currentPageIndex = 0
        }
        let indexPath = IndexPath.init(row: currentPageIndex, section: 0)
        self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageController.currentPage = currentPageIndex
    }

    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        let index = sender.currentPage
        let indexPath = IndexPath.init(row: index, section: 0)
        currentPageIndex = index
        self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageController.currentPage = currentPageIndex
    }
    
    
}







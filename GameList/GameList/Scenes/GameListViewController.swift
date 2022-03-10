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
    private var downLoadedImageList = [Int:UIImage]()
    
    @IBOutlet weak var gameListStackView: UICollectionView!
    @IBOutlet weak var bannerStackView: UIStackView!
    
    var currentPageIndex = 0
    var image = UIImage()
    var filteredGames = [Game?]()
    var isFiltering = false
    var myFirstSize = CGSize()
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
                Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.imageChange), userInfo: nil, repeats: true)
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
        myFirstSize = CGSize(width: view.frame.width * 0.95, height: gameListStackView.frame.height * 0.23)
        
        searchBar.delegate = self
        
        gameRequest.getGames { result in
            
            switch result{
            case .success(let games):
                self.games = games
            case .failure(let error):
                print(error.localizedDescription)

    
            }
        }
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

 //MARK: CollectionView Delegate and Datasource

extension GameListViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == bannerCollectionView){
            var rowCount = 0
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
}




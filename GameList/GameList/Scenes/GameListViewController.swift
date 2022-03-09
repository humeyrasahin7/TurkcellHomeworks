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
    
    private var downLoadedImageList = [Int:UIImage]()
    
    var currentPageIndex = 0
    var image = UIImage()
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
            }
        }
    }
    
    
    
    let gameRequest = GameListRequest()
    var detail: Detail?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailViewController.favoriteGames = DetailViewController.userDefaults.value(forKey: "favGames") as? [Int] ?? [Int]()
        print(DetailViewController.favoriteGames)
        initCollectionView(collectionView: collectionView)
        initCollectionView(collectionView: bannerCollectionView)
       
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.imageChange), userInfo: nil, repeats: true)
        pageController.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        
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
            return downLoadedImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = games.results[indexPath.row]
        let detailRequest = GameDetailRequest(slug: (game?.slug!)!)
        openDetail(detailRequest: detailRequest)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let game = games.results[indexPath.row]
        if (collectionView == bannerCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCell
            cell.bannerImage.image = downLoadedImageList[(game?.id)!]
            return cell
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






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
    
    var currentPageIndext = 0
    var image = UIImage()
    var games = Games(){
        didSet{
            DispatchQueue.main.async {
                
                for result in self.games.results{
                    let urlString = result?.background_image
                    print(urlString!)
                    
                    self.load(url: URL(string: (result?.background_image)!)! , complete: { image in
                       
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
        
        initCollectionView(collectionView: collectionView)
        initCollectionView(collectionView: bannerCollectionView)
       
        pageController.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        gameRequest.getGames { result in
            print(result)
            switch result{
            case .success(let games):
                self.games = games
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
    
            }
        }
        
       
    }

    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        let index = sender.currentPage
        let indexPath = IndexPath.init(row: index, section: 0)
        //let direction: UIPageViewController.NavigationDirection = currentPageIndext > index ? .reverse : .forward
        currentPageIndext = index
        self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageController.currentPage = currentPageIndext
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
        let detailRequest = GameDetailRequest(slug: (games.results[indexPath.row]?.slug)!)
        detailRequest.getDetail { [self] result in
            switch result{
            case .success(let detail):
                self.detail = detail
                DispatchQueue.main.async {
                    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else {return}
                    vc.detail = detail
        
                    print(detail)
                    self.navigationController?.pushViewController(vc, animated: true)
                  
                }
               
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
    
            }
        }
        
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
        guard let cell = bannerCollectionView.visibleCells.first else {return}
        let indexPath = bannerCollectionView.indexPath(for: cell)
        currentPageIndext = indexPath!.row
            print(currentPageIndext)
        
    }
}






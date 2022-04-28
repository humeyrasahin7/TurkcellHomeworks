//
//  ListViewController.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 27.04.2022.
//

import UIKit


protocol ListViewControllerProtocol: AnyObject{
    func reloadData()
    func setupCollectionView()
    func setupPageController()
    func setSelectorFunc()
    func setTimerSelectorFunc()
}


final class ListViewController: UIViewController {

    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    var presenter: ListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        presenter.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(imageChange), userInfo: nil, repeats: true)
    }
    
    @objc func imageChange(){
        setTimerSelectorFunc()
    }
    
    @objc func pageValueChanged(_ sender: UIPageControl){
        setSelectorFunc()
    }
}

extension ListViewController: ListViewControllerProtocol{
  
    
    func reloadData() {
        self.upcomingCollectionView.reloadData()
        self.nowPlayingCollectionView.reloadData()
    }
    
    
    func setupCollectionView() {
        upcomingCollectionView.dataSource = self
        nowPlayingCollectionView.dataSource = self
        upcomingCollectionView.delegate = self
        nowPlayingCollectionView.delegate = self
        upcomingCollectionView.register(cellType: ListCollectionViewCell.self)
        nowPlayingCollectionView.register(cellType: NowPlayingCollectionViewCell.self)
    }
    
    func setupPageController() {
        
        pageController.addTarget(self, action: #selector(pageValueChanged(_:)), for: .valueChanged)
        pageController.numberOfPages = presenter.numberOfItemsNP()
    }
    
    func setSelectorFunc() {
        presenter.setSelectorFunc(sender: pageController, collectionView: nowPlayingCollectionView)
    }
    
    func setTimerSelectorFunc() {
        presenter.setTimerSelectorFunc(sender: pageController, collectionView: nowPlayingCollectionView)
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rowCount: Int!
        if collectionView == upcomingCollectionView{
            rowCount = presenter.numberOfItemsUC()
        } else if collectionView == nowPlayingCollectionView{
            rowCount = presenter.numberOfItemsNP()
        }
        return rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == upcomingCollectionView{
            let cell = collectionView.dequeCell(cellType: ListCollectionViewCell.self, indexPath: indexPath)
            if let movie = presenter.movieUpcoming(indexPath.row) {
                cell.cellPresenter = ListCellPresenter(view: cell, movie: movie)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeCell(cellType: NowPlayingCollectionViewCell.self, indexPath: indexPath)
            if let movie = presenter.movieNowPlaying(indexPath.row){
                cell.cellPresenter = NowPlayingCellPresenter(view: cell, movie: movie)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == upcomingCollectionView{
            presenter.didSelectItemAt(index: indexPath.row, clicked: .upcoming)
        } else {
            presenter.didSelectItemAt(index: indexPath.row, clicked: .nowplaying)
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == nowPlayingCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.35)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == nowPlayingCollectionView{
            presenter.didScroll(scrollView, pageController: pageController)
        }
    }
    
    
}

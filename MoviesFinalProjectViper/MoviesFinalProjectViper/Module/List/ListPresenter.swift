//
//  ListPresenter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import Foundation
import UIKit

protocol ListPresenterProtocol: AnyObject{
    func viewDidLoad()
    func numberOfItemsNP() -> Int
    func numberOfItemsUC() -> Int
    func movieUpcoming(_ index: Int) -> UpcomingMovie?
    func movieNowPlaying(_ index: Int) -> NowPlayingMovie?
    func didSelectItemAt(index: Int, clicked: ClickedCollectionView)
    func setSelectorFunc(sender: UIPageControl, collectionView: UICollectionView)
    func setTimerSelectorFunc(sender: UIPageControl, collectionView: UICollectionView)
    func didScroll(_ scrollView: UIScrollView, pageController: UIPageControl)
}

enum ClickedCollectionView{
    case upcoming
    case nowplaying
}

final class ListPresenter{
    
    unowned var view: ListViewControllerProtocol?
    let router: ListRouterProtocol!
    let interactor: ListInteractorProtocol!
    
    private var upcomingMovies = [UpcomingMovie]()
    private var nowPlayingMovies = [NowPlayingMovie]()
    
    init(view: ListViewControllerProtocol, router: ListRouterProtocol, interactor: ListInteractorProtocol){
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension ListPresenter: ListPresenterProtocol{
    func viewDidLoad() {
        interactor.fetchUpcomingMovies()
        interactor.fetchNowPlayingMovies()
        view?.setupCollectionView()
        view?.setupPageController()
    }
    
    func numberOfItemsNP() -> Int {
        return nowPlayingMovies.count
    }
    
    func numberOfItemsUC() -> Int {
        return upcomingMovies.count
    }
    
    func movieUpcoming(_ index: Int) -> UpcomingMovie? {
        return upcomingMovies[safe: index]
    }
    
    func movieNowPlaying(_ index: Int) -> NowPlayingMovie? {
        return nowPlayingMovies[safe: index]
    }
    
    func didSelectItemAt(index: Int, clicked: ClickedCollectionView) {
        var movieID: Int!
        switch clicked {
        case .upcoming:
            guard let upcomingMovie = movieUpcoming(index) else {return}
            movieID = upcomingMovie.id
        case .nowplaying:
            guard let nowPlayingMovie = movieNowPlaying(index) else {return}
            movieID = nowPlayingMovie.id
        }
        router.navigate(.detail(movieID: movieID))
    }
    
    func setSelectorFunc(sender: UIPageControl, collectionView: UICollectionView) {
        let index = sender.currentPage
        let indexPath = IndexPath.init(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        sender.currentPage = index
    }
    
    func setTimerSelectorFunc(sender: UIPageControl, collectionView: UICollectionView) {
        var  current = sender.currentPage
        if current < numberOfItemsNP() - 1{
            current += 1
        } else {
            current = 0
        }
        let indexPath = IndexPath.init(row: current, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        sender.currentPage = current
    }
    
    func didScroll(_ scrollView: UIScrollView, pageController: UIPageControl) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        pageController.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
}

extension ListPresenter: ListInteractorOutputProtocol{
    func fetchNowPlayingMoviesOutput(result: NowPlayingResult) {

        switch result{
        case .success(let nowPlayingMoviesResult):
            nowPlayingMovies = nowPlayingMoviesResult.results!
            view?.setupPageController()
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchUpcomingMoviesOutput(result: UpcomingResult) {
        switch result{
        case .success(let upcomingMoviesResult):
            upcomingMovies = upcomingMoviesResult.results ?? []
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
}

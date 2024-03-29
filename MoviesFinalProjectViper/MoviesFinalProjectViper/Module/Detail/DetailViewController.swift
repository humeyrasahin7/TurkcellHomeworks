//
//  DetailViewController.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject{
    func reloadData()
    func setupCollectionView()
    func addTabGestureRecog()
    func setSelectorFunc()
    func addToFavs()
    func setButtonImg(_ isFav: Bool)
    func setPoster(_ imagePath: String)
    func setTitle(_ title: String)
    func setDescription(_ description: String)
    func setRatingLabel(_ rating: Double)
    func setReleaseDate(_ date: String)

}

final class DetailViewController: UIViewController {

    var presenter: DetailPresenterProtocol!
    
    var favMovies = [Int]()
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var desctiptionTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var similarCollectionView: UICollectionView!
    @IBOutlet weak var imdbImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favMovies = userDefaults.value(forKey: "favMovies") as? [Int] ?? [Int]()
        presenter.viewWillAppear(favMovies)
    }
    
    @IBAction func addFavButtonTapped(_ sender: Any) {
        addToFavs()
    }
    
    @objc func addTapGestureRegocnizerAction(){
        setSelectorFunc()
    }
    
}

extension DetailViewController: DetailViewControllerProtocol{
    
    func setReleaseDate(_ date: String) {
        self.releaseDateLabel.text = date
    }
    
    func setRatingLabel(_ rating: Double) {
        self.ratingLabel.text = "\(rating)"
    }
    
    
    func setDescription(_ description: String) {
        self.desctiptionTextView.text = description
    }
    
    func setPoster(_ imagePath: String) {
        let url = URL(string: imagePath)
            posterView.kf.indicatorType = .activity
        posterView.kf.setImage(with: url){ result in
            switch result{
            case .success(_):
                break
            case .failure(_):
                self.posterView.image = UIImage(systemName: "star")
            }
        }
        
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
        self.title = title
    }
    
    
    func reloadData() {
        self.similarCollectionView.reloadData()
    }
    
    func setupCollectionView() {
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
        similarCollectionView.register(cellType: SimilarMoviesCollectionViewCell.self)
    }
    
    func addTabGestureRecog() {
        let tapRegoc = UITapGestureRecognizer(target: self, action: #selector(addTapGestureRegocnizerAction))
        imdbImageView.addGestureRecognizer(tapRegoc)
        imdbImageView.isUserInteractionEnabled = true
    }
    
    func addToFavs() {
        favMovies = presenter.addToFavs()
        userDefaults.set(favMovies, forKey: "favMovies")
    }
    
    func setButtonImg(_ isFav: Bool) {
        if isFav{
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func setSelectorFunc() {
        presenter.addGestureRecognizer()
    }
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: SimilarMoviesCollectionViewCell.self, indexPath: indexPath)
        if let movie = presenter.similarMovie(indexPath.row){
            cell.presenter = SimilarMoviesCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row)
    }
}

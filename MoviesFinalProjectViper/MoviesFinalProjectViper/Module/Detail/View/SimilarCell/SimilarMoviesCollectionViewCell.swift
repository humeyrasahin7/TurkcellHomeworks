//
//  SimilarMoviesCollectionViewCell.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import UIKit
import Kingfisher

protocol SimilarMoviesCellProtocol: AnyObject{
    func setPoster(_ imagePath: String)
    func setTitle(_ title: String)
    func setReleaseYear(_ year: String)
    func configCell()
}



final class SimilarMoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    
    var presenter: SimilarMoviesCellPresenterProtocol!{
        didSet{
            presenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension SimilarMoviesCollectionViewCell: SimilarMoviesCellProtocol{
    func setPoster(_ imagePath: String) {
        let url = URL(string: imagePath)
        posterView.kf.indicatorType = .activity
        posterView.kf.setImage(with: url) { result in
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
    }
    
    func setReleaseYear(_ year: String) {
        self.releaseYearLabel.text = year
    }
    
    func configCell() {
        posterView.configView(radius: 10, width: 0, borderColor: nil)
    }
    
    
}

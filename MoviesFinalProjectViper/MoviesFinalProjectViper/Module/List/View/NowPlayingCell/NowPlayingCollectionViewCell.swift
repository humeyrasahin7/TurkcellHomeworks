//
//  NowPlayingCollectionViewCell.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import UIKit
import Kingfisher

protocol NowPlayingCollectionViewCellProtocol: AnyObject{
    func setPoster(_ imagePath: String)
    func setTitle(_ title: String)
    func configCell()
}



final class NowPlayingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellPresenter: NowPlayingCellPresenterProtocol!{
        didSet{
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


extension NowPlayingCollectionViewCell: NowPlayingCollectionViewCellProtocol{
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
        let color = #colorLiteral(red: 0.9999375939, green: 0.758449614, blue: 0.02824430354, alpha: 0.9968956954)
        self.titleLabel.text = title
        self.titleLabel.configView(radius: 10, width: 1, borderColor: color.cgColor)
    }
    
    func configCell() {
        let color = #colorLiteral(red: 0.9999375939, green: 0.758449614, blue: 0.02824430354, alpha: 0)
        self.configView(radius: 5, width: 3, borderColor: color.cgColor)
    }
    
}

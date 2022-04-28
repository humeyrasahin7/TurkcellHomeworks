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
        let color = #colorLiteral(red: 0.3153917817, green: 0.04432758737, blue: 0.06071960034, alpha: 0.8596078228)
        self.titleLabel.text = title
        self.titleLabel.configView(radius: 10, width: 1, borderColor: color.cgColor)
    }
    
    func configCell() {
        let color = #colorLiteral(red: 0.3252504127, green: 0.04432758737, blue: 0.06071960034, alpha: 1)
        self.configView(radius: 10, width: 3, borderColor: color.cgColor)
    }
    
}

//
//  ListCollectionViewCell.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 26.04.2022.
//

import UIKit

protocol ListCollectionViewCellProtocol: AnyObject{
    func setPoster(_ imagePath: String)
    func setTitle(_ title: String)
    func setDescription(_ description: String)
    func setReleaseDate(_ date: String)
    func configCell()
}

class ListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    let color = #colorLiteral(red: 0.9999375939, green: 0.758449614, blue: 0.02824430354, alpha: 1)
    
    var cellPresenter: ListCellPresenterProtocol!{
        didSet{
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension ListCollectionViewCell: ListCollectionViewCellProtocol{
    func setReleaseDate(_ date: String) {
        self.releaseDateLabel.text = date
    }
    
    func setPoster(_ imagePath: String) {
        let url = URL(string: imagePath)
        posterView.configView(radius: 5, width: 1, borderColor: color.cgColor)
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
        let titleColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.titleLabel.text = title
        self.titleLabel.configView(radius: 5, width: 1, borderColor: titleColor.cgColor )
    }
    
    func setDescription(_ description: String) {
        self.descriptionLabel.text = description
    }
    
    func configCell() {
        self.configView(radius: 0, width: 1.5, borderColor: color.cgColor)
    }
}

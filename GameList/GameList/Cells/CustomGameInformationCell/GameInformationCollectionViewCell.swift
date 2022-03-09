//
//  CollectionViewCell.swift
//  GameList
//
//  Created by Hümeyra Şahin on 6.03.2022.
//

import UIKit

class GameInformationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateAndDateLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCell()
    }
    func configCell(){
        self.layer.cornerRadius = 4
        self.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2142228891)
        self.image.layer.cornerRadius = 4
        self.nameLabel.layer.cornerRadius = 3
        self.nameLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2436620447)
        
        
        
    }
}

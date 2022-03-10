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
    @IBOutlet weak var gameInfoView: UIView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCell()
    }
    func configCell(){
        self.layer.cornerRadius = 5
        self.layer.borderColor = #colorLiteral(red: 0.531162262, green: 0.3038557768, blue: 0.3615435958, alpha: 0.6473509934)
        self.layer.borderWidth = 1
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 0.3660359383, blue: 0.4177060127, alpha: 0.716861548)
        self.image.layer.cornerRadius = 4
        self.nameLabel.layer.cornerRadius = 3
        self.gameInfoView.layer.cornerRadius = 4
        self.gameInfoView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.3002897351)
        
        
        //gameInfoView.backgroundColor = #colorLiteral(red: 1, green: 0.3660359383, blue: 0.4177060127, alpha: 0.716861548)
        //image.layer.cornerRadius = 5
       // image.layer.borderColor = #colorLiteral(red: 0.531162262, green: 0.3038557768, blue: 0.3615435958, alpha: 0.6473509934)
    }
}

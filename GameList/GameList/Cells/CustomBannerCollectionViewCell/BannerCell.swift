//
//  BannerCell.swift
//  GameList
//
//  Created by Hümeyra Şahin on 8.03.2022.
//

import UIKit

class BannerCell: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bannerImage.layer.cornerRadius = 15
        bannerImage.layer.borderWidth = 4
        bannerImage.layer.borderColor = #colorLiteral(red: 0.531162262, green: 0.3038557768, blue: 0.3615435958, alpha: 0.6473509934)
    }

}

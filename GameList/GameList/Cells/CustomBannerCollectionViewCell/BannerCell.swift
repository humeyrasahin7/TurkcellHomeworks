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
    }

}

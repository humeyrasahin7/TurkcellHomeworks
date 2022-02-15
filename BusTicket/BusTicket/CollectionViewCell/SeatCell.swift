//
//  SeatCell.swift
//  BusTicket
//
//  Created by Hümeyra Şahin on 14.02.2022.
//

import UIKit

class SeatCell: UICollectionViewCell {
    @IBOutlet weak var seatNumberLabel: UILabel!
    @IBOutlet weak var seatImage: UIImageView!
    var isThisChairSold = false
    let image = UIImage(named: "seat")?.withTintColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.54), renderingMode: .alwaysTemplate)
    override func awakeFromNib() {
        super.awakeFromNib()
        seatImage.translatesAutoresizingMaskIntoConstraints = false
        seatImage.layer.masksToBounds = true
        seatImage.image = image
    }

}

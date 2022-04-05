//
//  PostDetailCollectionViewCell.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 2.04.2022.
//

import UIKit

class PostDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var readCommentsButton: UIButton!
    
    var postId: Int!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var subView: UIView!
    
}

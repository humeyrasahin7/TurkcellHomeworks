//
//  PostCollectionViewCell.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 2.04.2022.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    
    var post: Post?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var subView: UIView!
}

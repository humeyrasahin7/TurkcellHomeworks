//
//  PostCommentsCollectionViewCell.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 2.04.2022.
//

import UIKit

class PostCommentsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var commentTitle: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var commentBody: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var commentView: UIView!
}

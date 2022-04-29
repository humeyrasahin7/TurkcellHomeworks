//
//  SearchTableViewCell.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 29.04.2022.
//

import UIKit

protocol SearchTableViewCellProtocol: AnyObject{
    func setTitle(_ title: String)
}

final class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var cellPresenter: SearchTableViewCellPresenter!{
        didSet{
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension SearchTableViewCell: SearchTableViewCellProtocol{
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
}

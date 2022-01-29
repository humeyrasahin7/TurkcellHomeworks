//
//  LanguageCell.swift
//  W4-HW
//
//  Created by Hümeyra Şahin on 29.01.2022.
//

import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var languageLevel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: LanguageModel){
        self.languageName.text = model.languageName
        self.languageLevel.text = model.languageLevel
    }
    
}

//
//  DetailViewController.swift
//  GameList
//
//  Created by Hümeyra Şahin on 6.03.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateAndRateLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var slug: String?
    var detail: Detail?
    
    
   
 
    var detailRequest: GameDetailRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.load(url: URL(string: (detail?.background_image)!)!, complete: { image in
            self.image.image = image
        })
        nameLabel.text = detail?.name
        descriptionText.text = detail?.description_raw
        
        }

    }
    


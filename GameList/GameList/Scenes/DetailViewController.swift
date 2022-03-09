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
    @IBOutlet weak var addFavButton: UIButton!
    
    var slug: String?
    var detail: Detail?
    var isFavorite: Bool!
    static var favoriteGames = [Int]()
    static let userDefaults = UserDefaults.standard
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detail = detail else { return }
        if DetailViewController.favoriteGames.contains(detail.id!){
            isFavorite = true
        } else {
            isFavorite = false
        }

        switch isFavorite{
        case true:
            addFavButton.imageView?.image = UIImage(systemName: "heart.fill")
        default:
            addFavButton.imageView?.image = UIImage(systemName: "heart")
        }
        self.load(url: URL(string: (detail.background_image!))!, complete: { image in
            self.image.image = image
        })
        nameLabel.text = detail.name
        dateAndRateLabel.text = "\(detail.rating!) - \(detail.released!)"
        descriptionText.text = detail.description_raw
        }
    
    override func viewWillAppear(_ animated: Bool) {
        DetailViewController.favoriteGames = DetailViewController.userDefaults.value(forKey: "favGames") as? [Int] ?? [Int]()
        guard let detail = detail else { return }
        if DetailViewController.favoriteGames.contains(detail.id!){
            isFavorite = true
        } else {
            isFavorite = false
        }

        switch isFavorite{
        case true:
            addFavButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            //addFavButton.imageView?.image = UIImage(systemName: "heart.fill")
        default:
            addFavButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
   /* override func viewWillDisappear(_ animated: Bool) {
        DetailViewController.userDefaults.set(DetailViewController.favoriteGames, forKey: "favGames")
        print(DetailViewController.favoriteGames)
    }*/
    
    @IBAction func addFavTapped(_ sender: UIButton) {
        print(DetailViewController.favoriteGames.count)
        if DetailViewController.favoriteGames.contains((detail?.id)!){
            addFavButton.setImage(UIImage(systemName: "heart"), for: .normal)
            DetailViewController.favoriteGames.remove(at: DetailViewController.favoriteGames.firstIndex(of: (detail?.id)!)!)
            
            
        } else {
            addFavButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            DetailViewController.favoriteGames.append(detail!.id!)
            
        }
        
        isFavorite = !isFavorite
        DetailViewController.userDefaults.set(DetailViewController.favoriteGames, forKey: "favGames")
    }
    
    }
    


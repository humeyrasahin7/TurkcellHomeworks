//
//  DetailViewController.swift
//  GameList
//
//  Created by Hümeyra Şahin on 6.03.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var gameInfoView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var metacriticRateLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var addFavButton: UIButton!
    
    var slug: String?
    var detail: Detail?
    var isFavorite: Bool!
    static var favoriteGames = [Int]()
    static let userDefaults = UserDefaults.standard
 
    //MARK: View Did Load
    
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
        configDetailView()
        nameLabel.text = detail.name
        releaseDateLabel.text = "\(detail.released!)"
        metacriticRateLabel.text = "\(detail.metacritic!)"
        descriptionText.text = detail.description_raw
        }
    

    //MARK: View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        default:
            addFavButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    @IBAction func addFavTapped(_ sender: UIButton) {
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
    
    func configDetailView(){
        gameInfoView.layer.cornerRadius = 5
        gameInfoView.layer.borderColor = #colorLiteral(red: 0.531162262, green: 0.3038557768, blue: 0.3615435958, alpha: 0.6473509934)
        gameInfoView.layer.borderWidth = 1
        gameInfoView.backgroundColor = #colorLiteral(red: 1, green: 0.3660359383, blue: 0.4177060127, alpha: 0.716861548)
        image.layer.cornerRadius = 5
        image.layer.borderColor = #colorLiteral(red: 0.531162262, green: 0.3038557768, blue: 0.3615435958, alpha: 0.6473509934)
        image.layer.borderWidth = 3
        descriptionText.layer.cornerRadius = 5
        descriptionText.layer.borderColor = #colorLiteral(red: 0.531162262, green: 0.3038557768, blue: 0.3615435958, alpha: 0.6473509934)
        descriptionText.layer.borderWidth = 1
        descriptionText.backgroundColor = #colorLiteral(red: 1, green: 0.3660359383, blue: 0.4177060127, alpha: 0.716861548)
        
    }
    
    
}

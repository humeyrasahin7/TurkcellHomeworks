//
//  CustomCollevtionViewController.swift
//  BusTicket
//
//  Created by Hümeyra Şahin on 21.02.2022.
//

import UIKit

private let reuseIdentifier = "seatCell"
class CustomCollectionViewController: UIViewController {
    
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var soldImage: UIImageView!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var availableImage: UIImageView!
    
    
    var ticket: Ticket?
    var selectedChairCount = 0
    var selectedChairs = [Int]()
    var soldChairs = [Int]()
    
    let userDefault = UserDefaults.standard
    let image = UIImage(named: "seat")?.withTintColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.54), renderingMode: .alwaysTemplate)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "SeatCell", bundle: nil), forCellWithReuseIdentifier: "seatCell")
        collectionView.setCollectionViewLayout(createSeats(), animated: true)
        configReserveButton()
        soldChairs = userDefault.array(forKey: "soldChairs") as? [Int] ?? [Int]()
        
        infoStackView.layer.cornerRadius = 20
        
        selectedImage.image = image
        selectedImage.tintColor = #colorLiteral(red: 0.5738236904, green: 0.003818957368, blue: 0.2348305285, alpha: 0.6287468112)
        
        soldImage.image = image
        soldImage.tintColor = .lightGray
        
        availableImage.image = image
        availableImage.tintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        
    }
    
    
    func createSeats() -> UICollectionViewLayout {
        let seatSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: seatSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 50, bottom: 5, trailing: -40)
        
        let rightSideGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(70))
        let rightSideGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rightSideGroupSize,
                                                                subitem: item, count: 2)
        
        let leftSideGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                                       heightDimension: .absolute(70))
        let leftSideGroup = NSCollectionLayoutGroup.horizontal(layoutSize: leftSideGroupSize, subitem: item, count: 1)
        
        let wholeSeatsGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        
        
        let wholeSeatsGroup = NSCollectionLayoutGroup.horizontal(layoutSize: wholeSeatsGroupSize, subitems: [leftSideGroup, rightSideGroup])
        
        wholeSeatsGroup.interItemSpacing = .fixed(60)
        
        let section = NSCollectionLayoutSection(group: wholeSeatsGroup)
        section.interGroupSpacing = 5
        
        let seatLayout = UICollectionViewCompositionalLayout(section: section)
        return seatLayout
    }
    
    func configReserveButton(){
        
        reserveButton.backgroundColor = #colorLiteral(red: 0.4694949389, green: 0.8043939471, blue: 0.8298689723, alpha: 0.3392591412)
        reserveButton.titleLabel?.font = UIFont(name: "Noteworthy", size: 19)
        reserveButton.setTitleColor(.darkGray, for: .normal)
        reserveButton.setTitle("Reserve", for: .normal)
        reserveButton.titleLabel?.textAlignment = .center
        reserveButton.layer.cornerRadius = 15
        reserveButton.addTarget(self, action: #selector(reserveClicked), for: .touchUpInside)
        reserveButton.translatesAutoresizingMaskIntoConstraints = false

    }
    //MARK: Reserve Action
    @objc func reserveClicked(){
        if selectedChairCount == 0{
            createAC(title: "UPS!", message: "You must choose at least 1 seat")
        } else {
            for i in 0...selectedChairs.count-1{
                soldChairs.append(selectedChairs[i])
            }
            userDefault.set(soldChairs, forKey: "soldChairs")
            let vc = storyboard?.instantiateViewController(withIdentifier: "ticketInfoVC") as! TicketInfoViewController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.ticket = ticket
            vc.ticket?.selectedChairCount = selectedChairCount
            vc.ticket?.selectedChairs = selectedChairs
            present(vc, animated: true)
        }
    }

}
//MARK: Delegate, Data Source
extension CustomCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 45
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SeatCell
        //MARK: Is sold control
        if soldChairs.contains(indexPath.row + 1){
            cell.tintColor = .lightGray
            cell.isUserInteractionEnabled = false
            cell.isThisChairSold = true
        } else {
            cell.tintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        }
        
        cell.seatNumberLabel.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SeatCell else {return}
        if selectedChairCount < 5{
            if selectedChairs.contains(indexPath.row + 1){
                cell.tintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                selectedChairs.remove(at: selectedChairs.firstIndex(of: (indexPath.row + 1))!)
                selectedChairCount -= 1
            } else{
                collectionView.cellForItem(at: indexPath)?.tintColor = #colorLiteral(red: 0.5738236904, green: 0.003818957368, blue: 0.2348305285, alpha: 0.6287468112)
                selectedChairCount += 1
                selectedChairs.append(indexPath.row + 1)
            }
            print(selectedChairs)
        } else {
            if selectedChairs.contains(indexPath.row + 1){
                cell.tintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                selectedChairs.remove(at: selectedChairs.firstIndex(of: (indexPath.row + 1))!)
                selectedChairCount -= 1
            } else {
                createAC(title: "UPS!", message: "You can't choose more than 5 seats")
            }
        }
    }
    
    
}

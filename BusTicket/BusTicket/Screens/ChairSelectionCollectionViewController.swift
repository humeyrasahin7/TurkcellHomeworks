//
//  ChairSelectionCollectionViewController.swift
//  BusTicket
//
//  Created by Hümeyra Şahin on 14.02.2022.
//

import UIKit

private let reuseIdentifier = "seatCell"

class ChairSelectionCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UINib(nibName: "SeatCell", bundle: nil), forCellWithReuseIdentifier: "seatCell")
        self.collectionView.setCollectionViewLayout(createSeats(), animated: true)
        addReserveButton()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 45
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SeatCell
        cell.tintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        cell.seatNumberLabel.text = "\(indexPath.row + 1)"
        return cell
    }
//MARK: Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.tintColor = #colorLiteral(red: 0.5738236904, green: 0.003818957368, blue: 0.2348305285, alpha: 0.6287468112)
        guard let cell = collectionView.cellForItem(at: indexPath) as? SeatCell else {return}
        //cell.isThisChairSelected = true
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
       
        
        let wholeSeatsGroup = NSCollectionLayoutGroup.horizontal(layoutSize: wholeSeatsGroupSize, subitems: [leftSideGroup, rightSideGroup, rightSideGroup])
        
        wholeSeatsGroup.interItemSpacing = .fixed(60)
        
        let section = NSCollectionLayoutSection(group: wholeSeatsGroup)
        section.interGroupSpacing = 5
        
        let seatLayout = UICollectionViewCompositionalLayout(section: section)
        return seatLayout
    }
    
    func addReserveButton(){
        let reserveButton = UIButton()
        reserveButton.backgroundColor = #colorLiteral(red: 0.4694949389, green: 0.8043939471, blue: 0.8298689723, alpha: 0.3392591412)
        reserveButton.titleLabel?.font = UIFont(name: "Noteworthy", size: 19)
        reserveButton.setTitleColor(.darkGray, for: .normal)
        reserveButton.setTitle("Reserve", for: .normal)
        reserveButton.titleLabel?.textAlignment = .center
        reserveButton.layer.cornerRadius = 15
        reserveButton.addTarget(self, action: #selector(reserveClicked), for: .touchUpInside)
        collectionView.addSubview(reserveButton)
        
        NSLayoutConstraint.activate([
            reserveButton.trailingAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.trailingAnchor, constant: -140),
            reserveButton.leadingAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.leadingAnchor, constant: 140),
            reserveButton.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            reserveButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
        reserveButton.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc func reserveClicked(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ticketInfoVC") as! TicketInfoViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
}

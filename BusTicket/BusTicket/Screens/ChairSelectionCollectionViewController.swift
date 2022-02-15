//
//  ChairSelectionCollectionViewController.swift
//  BusTicket
//
//  Created by Hümeyra Şahin on 14.02.2022.
//

import UIKit

private let reuseIdentifier = "seatCell"

class ChairSelectionCollectionViewController: UICollectionViewController {

    var ticket: Ticket?
    var selectedChairCount = 0
    var selectedChairs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UINib(nibName: "SeatCell", bundle: nil), forCellWithReuseIdentifier: "seatCell")
        self.collectionView.setCollectionViewLayout(createSeats(), animated: true)
        addReserveButton()
        print(ticket)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? SeatCell else {return}
        if selectedChairCount < 5{
            if selectedChairs.contains(indexPath.row + 1){
                cell.tintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                selectedChairs.remove(at: selectedChairs.firstIndex(of: (indexPath.row + 1))!)
                selectedChairCount -= 1
            } else {
                collectionView.cellForItem(at: indexPath)?.tintColor = #colorLiteral(red: 0.5738236904, green: 0.003818957368, blue: 0.2348305285, alpha: 0.6287468112)
                selectedChairCount += 1
                selectedChairs.append(indexPath.row + 1)
            }
            print(selectedChairs)
        } else {
            let ac = UIAlertController(title: "Ups!", message: "You can't choose more than 5 seats", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            present(ac, animated: true)
        }
        
    }
    
    //MARK: Create Seats
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
        if selectedChairCount == 0{
            let ac = UIAlertController(title: "UPS!", message: "You must choose at leaast 1 seat", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        } else {
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

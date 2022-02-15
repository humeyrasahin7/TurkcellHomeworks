//
//  TicketInfoViewController.swift
//  BusTicket
//
//  Created by Hümeyra Şahin on 14.02.2022.
//

import UIKit

class TicketInfoViewController: UIViewController {
    
    
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var infoMainView: UIView!
    @IBOutlet weak var destinationView: UIView!
    @IBOutlet weak var passengerInfoView: UIView!
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var dateInfoLabel: UILabel!
    @IBOutlet weak var passengerInfoLabel: UILabel!
    @IBOutlet weak var reservedSeatsLabel: UILabel!
    
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var ticket: Ticket!
    var hour: String!
    var minute: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.layer.cornerRadius = 30
        infoMainView.layer.cornerRadius = 30
        destinationView.layer.cornerRadius = 30
        passengerInfoView.layer.cornerRadius = 30
        priceView.layer.cornerRadius = 30
        
        fromLabel.adjustsFontSizeToFitWidth = true
        fromLabel.minimumScaleFactor = 0.7
        toLabel.adjustsFontSizeToFitWidth = true
        toLabel.minimumScaleFactor = 0.7
        
        reservedSeatsLabel.adjustsFontSizeToFitWidth = true
        reservedSeatsLabel.minimumScaleFactor = 0.7
        
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.minimumScaleFactor = 0.7
        
        fromLabel.text = ticket.from?.uppercased()
        toLabel.text = ticket.to?.uppercased()
        
        if ticket.clock.hour == 0{
            hour = "00"
        } else{
            hour = "\(ticket.clock.hour)"
        }
        
        if ticket.clock.minute == 0{
            minute = "00"
        } else {
            minute = "\(ticket.clock.minute)"
        }
        
        var reservedChairs = "\(ticket.selectedChairs!.sorted())"
        reservedChairs.remove(at: reservedChairs.startIndex)
        reservedChairs.remove(at: (reservedChairs.index(before: reservedChairs.endIndex)))
        
        dateInfoLabel.text = "\(ticket.date.day)/\(ticket.date.month)/\(ticket.date.year) - \(hour!) : \(minute!)"
        
        passengerInfoLabel.text = "\(ticket.passenger.name.capitalized) \(ticket.passenger.surname.capitalized)"
        
        reservedSeatsLabel.text = reservedChairs
    
        priceLabel.text = "\(ticket.selectedChairCount! * 80)₺"
    }
   


}

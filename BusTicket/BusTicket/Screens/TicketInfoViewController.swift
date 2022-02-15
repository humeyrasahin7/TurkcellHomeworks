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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.layer.cornerRadius = 30
        infoMainView.layer.cornerRadius = 30
        destinationView.layer.cornerRadius = 30
        passengerInfoView.layer.cornerRadius = 30
                
    }
   


}

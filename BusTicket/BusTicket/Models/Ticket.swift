//
//  Ticket.swift
//  BusTicket
//
//  Created by Hümeyra Şahin on 13.02.2022.
//

import Foundation
import UIKit

struct Ticket{
    var passenger: Passenger
    var date: TicketDate
    var clock: Clock
    var from: String?
    var to: String?
    var isChairSelected = false
    var selectedChairCount: Int?
    var selectedChairs: [Int]?
    //MARK: Methods
    
    func reserveChair(selectedChair: Int){
        if !(selectedChair < 1 && selectedChair > 5){
            //TODO:
        } else {
            let ac = UIAlertController(title: "Choose Again!", message: "You've choose ", preferredStyle: .alert)
            
        }
    }
}

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
    var selectedChairCount: Int?
    var selectedChairs: [Int]?
}

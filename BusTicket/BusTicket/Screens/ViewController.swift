//
//  ViewController.swift
//  BusTicket
//
//  Created by Hümeyra Şahin on 12.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var destinationInfoView: UIView!
    
    @IBOutlet weak var passengerName: UITextField!
    @IBOutlet weak var passengerSurname: UITextField!
    @IBOutlet weak var passengerID: UITextField!
    
    @IBOutlet weak var routeFrom: UITextField!
    @IBOutlet weak var routeTo: UITextField!
    
    @IBOutlet weak var dateView: UIView!

    @IBOutlet weak var datePicker: UIDatePicker!
    

    var date = TicketDate()
    var clock =  Clock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoView.layer.cornerRadius = 20
        destinationInfoView.layer.cornerRadius = 20
        dateView.layer.cornerRadius = 20
        self.hideKeyboard()
    }

    //MARK: Go To Chair Selection
    @IBAction func goToChairSelection(_ sender: UIButton) {
        if passengerName.text!.isEmpty ||
            passengerSurname.text!.isEmpty ||
            passengerID.text!.isEmpty  ||
            routeTo.text!.isEmpty ||
            routeFrom.text!.isEmpty {
            
            let ac = UIAlertController(title: "UPS!", message: "You must write all of you informations", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OKAY", style: .default, handler: nil))
            present(ac, animated: true)
        } else {
        
        let passenger = Passenger(name: passengerName.text!, surname: passengerSurname.text!, id: Int(passengerID.text!)!)
        
            let ticket = Ticket(passenger: passenger, date: date, clock: clock,from: routeFrom.text, to: routeTo.text, isChairSelected: true, selectedChairCount: nil, selectedChairs: nil)
            
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "chairCollectionView") as! ChairSelectionCollectionViewController
        vc.ticket = ticket
        vc.modalPresentationStyle = .popover
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
        }
    }
    
    //MARK: Date Value Changed
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        let components = sender.calendar.dateComponents([.day,.month,.year,.hour,.minute], from: sender.date)
        
        date.day = String(components.day!)
        date.month = String(components.month!)
        date.year = String(components.year!)
        
        clock.hour = components.hour!
        clock.minute = components.minute!
        
    }
    
}

//MARK: Hide Keyboard

extension UIViewController {
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

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
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoView.layer.cornerRadius = 20
        destinationInfoView.layer.cornerRadius = 20
        dateView.layer.cornerRadius = 20
        
        
    }

    @IBAction func goToChairSelection(_ sender: UIButton) {
        //ticket.passenger.name = passengerName.text!
        
        /*
        ticket.passenger.surname = passengerSurname.text!
        ticket.passenger.id = try! Int(passengerID.text!, format: .number)
        ticket.passenger.printPassenger()*/
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "chairCollectionView")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
    }
    
}


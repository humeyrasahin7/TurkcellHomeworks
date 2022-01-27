//
//  ViewController.swift
//  W3-HW4
//
//  Created by Hümeyra Şahin on 26.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var velocityText: UITextField!
    @IBOutlet weak var bottleSizeLabel: UILabel!
    @IBOutlet weak var gamerNameText: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var allertLabel: UILabel!
    @IBOutlet weak var fireButton: UIButton!
    
    
    var gamer = Gamer(name: "", score: 0)
    var bottle = Bottle(location: 0, state: true)
    var range = Range(velocity: 0, teta: 0)
    var d: Double!
    override func viewDidLoad() {
        super.viewDidLoad()
        bottleSizeLabel.text = "Şişe Boyutu: \(bottle.size)"
    }
    @IBAction func startTapped(_ sender: UIButton) {
        velocityText.isEnabled = true
        startButton.isEnabled = true
        angleSlider.isEnabled = true
        distanceSlider.isEnabled = true
        fireButton.isEnabled = true
        allertLabel.isHidden = true
        gamer.name = gamerNameText.text!
        gamerNameText.isEnabled = false
        startButton.isEnabled = false
    }
    
    @IBAction func tetaSlider(_ sender: UISlider) {
        range.teta = Double(sender.value)
    }
    
    @IBAction func bottleDistance(_ sender: UISlider) {
        bottle.location = Double(sender.value)
        d = bottle.location
    }
    @IBAction func fireTapped(_ sender: Any) {
        
        print("distance: \(d!)")
        let velocity = velocityText.text!
        range.velocity = Double(velocity)!
        let r = range.calculateRange(velocity: range.velocity, teta: range.teta)
        print(r)
        if r >= (d - bottle.size) && r <= (d + bottle.size){
            bottle.state = false
            gamer.score += 10
            scoreLabel.text = "Score: \(gamer.score)"
            range.teta = 0
            range.velocity = 0
            bottle.location = 0
            allertLabel.isHidden = false
            allertLabel.text = "Tebrikler \(gamer.name)! Atış Başarılı"
        } else {
            allertLabel.isHidden = false
            allertLabel.text = "Iska! Lütfen Tekrar Deneyiniz"
        }
    }
    
}




//
//  ViewController.swift
//  Challenge
//
//  Created by Hümeyra Şahin on 16.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var giftCodeSV: UIStackView!
    @IBOutlet weak var giftCodeContainerView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    
    
    
    @IBOutlet weak var resultSV: UIStackView!
    @IBOutlet weak var resultContainerView: UIView!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    
    
    let myCodes = ["ASDF10","DC20DC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giftCodeContainerView.configView()
        resultContainerView.configView()
        resultSV.isHidden = true
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        let input = inputTextField.text?.uppercased()
        var isContains = false
        for code in myCodes{
            if code == input {
                isContains = true
            }
        }
        switch isContains{
        case true:
            giftCodeSV.isHidden = true
            resultSV.isHidden = false
            discountLabel.text = "%20 Hoşgelgin İndirimi"
            discountPriceLabel.text = "-123,00 TL"
            createAC(title: "Tebrikler", message: "123,00 TL indiriminiz tanımlandı!")
        case false:
            createAC(title: "Girdiğiniz Kod Geçerli Değil", message: "Hediye Kodunu hatalı girmiş olabilirsiniz veya kullandığınız kodun geçerlilik süresi dolmuş olabilir.")
        }
        inputTextField.text = ""
    
    }
    @IBAction func dismissDiscountButtonTapped(_ sender: Any) {
        resultSV.isHidden = true
        giftCodeSV.isHidden = false
    }
    

}

extension UIViewController{
    
    func createAC(title: String, message: String){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "customAC") as! CustomAlertViewController
        _ = vc.view
        vc.createCustomAC(title: title, detail: message)
        UIView.transition(with: self.view, duration: 0.1, options: [.transitionCrossDissolve], animations: {
            self.addChild(vc)
            self.view.addSubview(vc.view)
        }, completion: nil)
        
    }
}

extension UIView{
    func configView(){
        self.layer.borderColor = #colorLiteral(red: 0.2119759023, green: 0.2320075333, blue: 0.2666666667, alpha: 0.2502845613)
        self.layer.borderWidth = 1.25
        self.layer.cornerRadius = 10
    }
}


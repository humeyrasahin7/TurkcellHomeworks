//
//  SenderViewController.swift
//  W4-HW
//
//  Created by Hümeyra Şahin on 29.01.2022.
//

import UIKit

protocol AddNewDelegate{
    func saveNewLanguage(newLanguage: String, languageLevel: String)
}


class SenderViewController: UIViewController {

    @IBOutlet weak var newLanguageLabel: UITextField!
    @IBOutlet weak var newLevelLabel: UITextField!
    var delegate: AddNewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard let newLanguage = newLanguageLabel.text,
              let newLevel = newLevelLabel.text else {return}
        self.delegate?.saveNewLanguage(newLanguage: newLanguage, languageLevel: newLevel)
        dismiss(animated: true)
    }
    
}
 

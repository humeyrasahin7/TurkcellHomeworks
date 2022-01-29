//
//  ViewController.swift
//  W4-HW
//
//  Created by Hümeyra Şahin on 29.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var languages = [LanguageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languages.append(LanguageModel(languageName: "English", languageLevel: "Upper Intermediate"))
        languages.append(LanguageModel(languageName: "Korean", languageLevel: "Upper Intermediate"))
        tableView.register(UINib(nibName: "LanguageCell", bundle: nil), forCellReuseIdentifier: "languageCell")
    }

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Add New Language", message: "Please Add New Language and Level", preferredStyle: .alert)
        ac.addTextField { (languageField : UITextField!) -> Void in
            languageField.placeholder = "Please Enter Language"
            languageField.autocapitalizationType = .words
        }
        ac.addTextField { (levelField : UITextField!) -> Void in
            levelField.placeholder = "Please Enter Language Level"
            levelField.autocapitalizationType = .words
        }
        let save = UIAlertAction(title: "Save", style: .default) { alert -> Void in
            let newLanguage = LanguageModel(languageName: ac.textFields![0].text!, languageLevel: ac.textFields![1].text!)
            self.languages.append(newLanguage)
            self.tableView.reloadData()
        }
        ac.addAction(save)
        present(ac, animated: true)
    }
    
    @IBAction func addWithDelegate(_ sender: UIBarButtonItem) {
        let senderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SenderVC") as! SenderViewController
        senderVC.delegate = self
        present(senderVC, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, AddNewDelegate{
    
    func saveNewLanguage(newLanguage: String, languageLevel: String) {
        let newLanguage = LanguageModel(languageName: newLanguage, languageLevel: languageLevel)
        self.languages.append(newLanguage)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageCell
        cell.configureCell(model: languages[indexPath.row])
        return cell
    }

    
}


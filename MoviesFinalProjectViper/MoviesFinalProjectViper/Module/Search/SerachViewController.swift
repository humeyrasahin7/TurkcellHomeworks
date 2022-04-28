//
//  SerachViewController.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import UIKit

protocol SerachViewControllerProtocol: AnyObject{
    func reloadData()
    func setupTableView()
}

final class SerachViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

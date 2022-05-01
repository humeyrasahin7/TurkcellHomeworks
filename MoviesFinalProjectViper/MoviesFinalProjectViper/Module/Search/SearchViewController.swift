//
//  SerachViewController.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 28.04.2022.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject{
    func reloadData()
    func setupTableView()
}

final class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SearchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        presenter.viewDidLoad()
    }

}

extension SearchViewController: SearchViewControllerProtocol{
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.register(cellType: SearchTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        
    }
    
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let movie = presenter.movie(indexPath.row) {
            cell.cellPresenter = SearchTableViewCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
}


extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let text = searchBar.text!
        if text.count >= 2{
            presenter.fetchSearchResults(query: text)
        }
    }
    
    
}

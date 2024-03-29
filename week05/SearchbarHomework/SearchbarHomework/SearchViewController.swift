//
//  ViewController.swift
//  SearchbarHomework
//
//  Created by Hümeyra Şahin on 7.02.2022.
//

import UIKit

class SearchViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var users = [User]()
    var filteredUsers = [User]()
    var isFiltering: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        guard let userURL = URL(string: urlStr) else { return }
        //let data = try? Data(contentsOf: userURL)
        let userList = try? JSONDecoder().decode([User].self, from: Data(contentsOf: userURL))
        guard let users = userList else { return }
        self.users = users
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
    }


}



//MARK: Table view data source
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            if filteredUsers.count == 0{
                return 1
            } else {
                return filteredUsers.count
            }
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        let user: User
        
        if isFiltering {
            if filteredUsers.count == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell")
                cell?.textLabel?.text = "No Match Found"
                return cell!
            } else {
                user = filteredUsers[indexPath.row]
            }
        } else {
            user = users[indexPath.row]
        }
        
        cell?.textLabel?.text = user.username
        cell?.detailTextLabel?.text = user.email
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight = 43.5
        if isFiltering{
            if filteredUsers.count == 0{
                cellHeight = tableView.frame.height
                return cellHeight
            }

        }
        return cellHeight
    }
    
}

//MARK: Searchbar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        //MARK: Clear button tapped
        if searchText == "" {
            isFiltering = false
            tableView.reloadData()
        } else {
        
        filteredUsers = users.filter({ (user:User) -> Bool in
            return user.username.lowercased().contains(searchText.lowercased())
        })
        
        isFiltering = true
        tableView.reloadData()
        
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}


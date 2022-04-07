//
//  UserViewController.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 2.04.2022.
//

import UIKit

class UserViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MyBlog"
        customizeNavigationBackButton(title: title!)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        viewModel.delegate = self
        viewModel.loadUsers()
        
    }


}

//MARK: Extensions

extension UserViewController: UserViewModelDelegate{
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - CollectionView Delegate and Data Source
extension UserViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfUsers
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! UserCollectionViewCell
        
        cell.containerView.configView()
        cell.subView.configView()
        
        if let user = viewModel.user(index: indexPath.row) {
            cell.usernameLabel.text = user.username
            cell.nameLabel.text = user.name
            cell.emailLabel.text = user.email
        }
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "postsVC") as! UserPostsViewController
        vc.userId = (viewModel.user(index: indexPath.row)?.id)!
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - CollectionView Delegate Flow Layout
extension UserViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = viewModel.calculateCellSize(collectionViewHeight: collectionView.frame.height, collectionViewWidht: collectionView.frame.width)
        let cellWidth = cellSize.width
        let cellHeight = cellSize.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

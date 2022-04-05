//
//  UserPostsViewController.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 2.04.2022.
//

import UIKit

class UserPostsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var userId : Int?
    var viewModel = UserPostsViewModel()
    var filteredPosts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        viewModel.loadPosts()
       
    }
    

}


//MARK: Extensions

extension UserPostsViewController: UserPostsViewModelDelegate{
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func filter(){
        for i in 0...self.viewModel.numberOfPosts - 1{
            if self.viewModel.post(index: i)?.userId == self.userId{
                 self.filteredPosts.append(viewModel.post(index: i)!)
             }
        }
    }
    
}

//MARK: - CollectionView Delegate and Data Source

extension UserPostsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return filteredPosts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCollectionViewCell
        cell.containerView.configView()
        cell.subView.configView()
        cell.postTitle.text = filteredPosts[indexPath.row].title
        cell.showMoreButton.tag = indexPath.row
        cell.showMoreButton.addTarget(self, action: #selector(showDetail(_ :)), for: .touchUpInside)
        return cell
    }
    
    @objc func showDetail(_ sender: UIButton){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "postDetailsVC") as! PostDetailsViewController
        vc.post = self.filteredPosts[sender.tag]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - CollectionView Delegate Flow Layout
extension UserPostsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = viewModel.calculateCellSize(collectionViewHeight: collectionView.frame.height, collectionViewWidht: collectionView.frame.width)
        let cellWidth = cellSize.width
        let cellHeight = cellSize.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
}


//
//  PostCommentsViewController.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 2.04.2022.
//

import UIKit

class PostCommentsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var postId: Int!
    var viewModel = PostCommentsViewModel()
    var filteredComments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post Comments"
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        viewModel.loadComments()
    }
    

}

//MARK: Extensions

extension PostCommentsViewController: PostCommentsViewModelDelegate{
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func filter() {
        for i in 0...self.viewModel.numberOfComments - 1{
            if self.viewModel.comment(index: i)?.postId == self.postId{
                 self.filteredComments.append(viewModel.comment(index: i)!)
             }
        }
    }
}

//MARK: - CollectionView Delegate and Data Source
extension PostCommentsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredComments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let comment = filteredComments[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath) as! PostCommentsCollectionViewCell
        cell.containerView.configView()
        cell.userInfoView.configView()
        cell.commentView.configView()
        cell.commentTitle.text = comment.name
        cell.userEmail.text = comment.email
        cell.commentBody.text = comment.body
        return cell
    }
    
    
}
//MARK: - CollectionView Delegate Flow Layout
extension PostCommentsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = viewModel.calculateCellSize(collectionViewHeight: collectionView.frame.height, collectionViewWidht: collectionView.frame.width)
        let cellWidth = cellSize.width
        let cellHeight = cellSize.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

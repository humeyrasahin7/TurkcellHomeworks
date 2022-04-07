//
//  PostDetailsViewController.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 2.04.2022.
//

import UIKit

class PostDetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = PostDetailsViewModel()
    var post: Post?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        customizeNavigationBackButton(title: title!)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    
}

//MARK: - CollectionView Delegate and Data Source
extension PostDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postDetailCell", for: indexPath) as! PostDetailCollectionViewCell
        cell.containerView.configView()
        cell.subView.configView()
        cell.title.text = post?.title
        cell.body.text = post?.body
        cell.readCommentsButton.tag = (post?.id)!
        cell.readCommentsButton.addTarget(self, action: #selector(readCommentsAction(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func readCommentsAction(_ sender: UIButton){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "commentsVC") as! PostCommentsViewController
        vc.postId = sender.tag
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CollectionView Delegate Flow Layout
extension PostDetailsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = viewModel.calculateCellSize(collectionViewHeight: collectionView.frame.height, collectionViewWidht: collectionView.frame.width)
        let cellWidth = cellSize.width
        let cellHeight = cellSize.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

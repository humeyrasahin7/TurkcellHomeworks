//
//  UserPostsViewModel.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 3.04.2022.
//

import Foundation


protocol UserPostsViewModelProtocol{
    var delegate: UserPostsViewModelDelegate? {get set}
    var numberOfPosts: Int {get}
    func loadPosts()
    func post(index: Int) -> Post?
    func calculateCellSize(collectionViewHeight: Double, collectionViewWidht: Double) -> (width: Double, height: Double)
}


protocol UserPostsViewModelDelegate: AnyObject{
    func reloadData()
    func filter()
}

final class UserPostsViewModel{
    private var posts: [Post] = []
    weak var delegate: UserPostsViewModelDelegate?
    let service = PostRequest()
    
    fileprivate func getPosts(){
        service.getPosts { result in
            switch result {
            case .success(let posts):
                self.posts = posts
                self.delegate?.filter()
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension UserPostsViewModel: UserPostsViewModelProtocol{
 
    var numberOfPosts: Int {
        posts.count
    }
    
    func loadPosts() {
        getPosts()
    }
    
    func post(index: Int) -> Post? {
        posts[index]
    }
    
    func calculateCellSize(collectionViewHeight: Double, collectionViewWidht: Double) -> (width: Double, height: Double) {
        let cellWidht = collectionViewWidht * 0.95
        let cellHeight = collectionViewHeight * 0.2
        return (cellWidht, cellHeight)
    }
    
}

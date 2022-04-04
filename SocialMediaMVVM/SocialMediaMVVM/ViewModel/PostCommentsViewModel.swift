//
//  PostCommentsViewModel.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 3.04.2022.
//

import Foundation

protocol PostCommentsViewModelProtocol{
    var delegate: PostCommentsViewModelDelegate? {get set}
    var numberOfComments: Int {get}
    func loadComments()
    func comment(index: Int) -> Comment?
    func calculateCellSize(collectionViewHeight: Double, collectionViewWidht: Double) -> (width: Double, height: Double)
}

protocol PostCommentsViewModelDelegate: AnyObject{
    func reloadData()
    func filter()
}

final class PostCommentsViewModel{
    private var comments: [Comment] = []
    weak var delegate: PostCommentsViewModelDelegate?
    let service = CommentRequest()
    
    fileprivate func getComments(){
        service.getComments { result in
            switch result{
            case .success(let comments):
                self.comments = comments
                self.delegate?.filter()
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PostCommentsViewModel: PostCommentsViewModelProtocol{
    
    var numberOfComments: Int {
        comments.count
    }
    
    func loadComments() {
        getComments()
    }
    
    func comment(index: Int) -> Comment? {
        comments[index]
    }
    
    func calculateCellSize(collectionViewHeight: Double, collectionViewWidht: Double) -> (width: Double, height: Double) {
        let cellWidht = collectionViewWidht * 0.95
        let cellHeight = collectionViewHeight * 0.6
        return (cellWidht, cellHeight)
    }
    
    
}

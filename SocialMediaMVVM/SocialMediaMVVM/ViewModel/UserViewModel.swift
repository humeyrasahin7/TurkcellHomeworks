//
//  UserViewModel.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 3.04.2022.
//

import Foundation

protocol UserViewModelProtocol{
    var delegate: UserViewModelDelegate? {get set}
    var numberOfUsers: Int {get}
    func loadUsers()
    func user(index: Int) -> User?
    func calculateCellSize(collectionViewHeight: Double, collectionViewWidht: Double) -> (width: Double, height: Double)
}

protocol UserViewModelDelegate: AnyObject{
    func reloadData()
}


final class UserViewModel {
    
    private var users: [User] = []
    weak var delegate: UserViewModelDelegate?
    let service = UserRequest()
    
    fileprivate func getUsers(){
        service.getUsers { result in
            switch result{
            case .success(let users):
                self.users = users
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UserViewModel: UserViewModelProtocol{
    var numberOfUsers: Int {
        users.count
    }
    
    func loadUsers() {
        getUsers()
    }
    
    func user(index: Int) -> User? {
        users[index]
    }
    
    func calculateCellSize(collectionViewHeight: Double, collectionViewWidht: Double) -> (width: Double, height: Double) {
        let cellWidht = collectionViewWidht * 0.95
        let cellHeight = collectionViewHeight * 0.2
        return (cellWidht, cellHeight)
    }
    
    
}

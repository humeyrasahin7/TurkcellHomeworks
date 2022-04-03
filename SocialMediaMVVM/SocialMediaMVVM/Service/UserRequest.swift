//
//  UserRequest.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 3.04.2022.
//

import Foundation

enum UserError: Error{
    case noDataAvailable
    case canNotProcessData
}

struct UserRequest{
    let resourceURL: URL
    
    init(){
        let resourceString = "https://jsonplaceholder.typicode.com/users"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("error")
        }
        self.resourceURL = resourceURL
    }
    
    func getUsers(completion: @escaping(Result<[User], UserError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: jsonData)
                completion(.success(users))
            } catch {

                completion(.failure(.canNotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
    
    
}

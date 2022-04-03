//
//  CommentRequest.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 3.04.2022.
//

import Foundation

enum CommentError: Error{
    case noDataAvailable
    case canNotProcessData
}

struct CommentRequest{
    let resourceURL: URL
    
    init(){
        let resourceString = "https://jsonplaceholder.typicode.com/comments"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("error")
        }
        self.resourceURL = resourceURL
    }
    
    func getComments(completion: @escaping(Result<[Comment], CommentError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let comments = try decoder.decode([Comment].self, from: jsonData)
                completion(.success(comments))
            } catch {
                completion(.failure(.canNotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
    
    
}

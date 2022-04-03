//
//  PostsRequest.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 3.04.2022.
//

import Foundation

enum PostError: Error{
    case noDataAvailable
    case canNotProcessData
}

struct PostRequest{
    let resourceURL: URL
    
    init(){
        let resourceString = "https://jsonplaceholder.typicode.com/posts"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("error")
        }
        self.resourceURL = resourceURL
    }
    
    func getPosts(completion: @escaping(Result<[Post], PostError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: jsonData)
                completion(.success(posts))
                
            } catch {
            
                completion(.failure(.canNotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
    
    
}

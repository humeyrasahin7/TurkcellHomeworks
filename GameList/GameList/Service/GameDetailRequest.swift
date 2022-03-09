//
//  GameDetailRequest.swift
//  GameList
//
//  Created by Hümeyra Şahin on 6.03.2022.
//

import Foundation

enum DetailError: Error{
    case noDataAvailable
    case canNotProcessData
}

struct GameDetailRequest{
    let resourceURL: URL
    var slug: String!
    
    init(slug: String){
        let resourceString = "https://api.rawg.io/api/games/\(slug)?key=36653b9e89654cf58ac1cbe6d02a4df1"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("error")
        }
        self.resourceURL = resourceURL
        
    }
    
    func getDetail(completion: @escaping(Result<Detail, DetailError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
          
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let detail = try decoder.decode(Detail.self, from: jsonData)
                completion(.success(detail))
            } catch {
            
                completion(.failure(.canNotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
}

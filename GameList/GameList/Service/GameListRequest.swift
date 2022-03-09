//
//  GameListRequest.swift
//  GameList
//
//  Created by Hümeyra Şahin on 6.03.2022.
//

import Foundation

enum GameError: Error{
    case noDataAvailable
    case canNotProcessData
}

struct GameListRequest{
    let resourceURL: URL
    
    init(){
        let resourceString = "https://api.rawg.io/api/games?key=36653b9e89654cf58ac1cbe6d02a4df1"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("error")
        }
        self.resourceURL = resourceURL
    }
    
    func getGames(completion: @escaping(Result<Games, GameError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
          
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let games = try decoder.decode(Games.self, from: jsonData)
                completion(.success(games))
            } catch {
            
                completion(.failure(.canNotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
    
    
}


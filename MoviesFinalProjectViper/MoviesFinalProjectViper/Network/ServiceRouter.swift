//
//  ServiceRouter.swift
//  MoviesFinalProjectViper
//
//  Created by Hümeyra Şahin on 25.04.2022.
//

import Foundation
import Alamofire

enum ServiceRouter: URLRequestConvertible{
    
    static let api_key = "cdbf55aa5f7207adf7c45ff96456dc74"
    
    case nowPlaying
    case upcoming
    case similar(movieId: Int?)
    case detail(movieId: Int?)
    case search(query: String?)
    
    var baseURL: URL{
        return URL(string: "https://api.themoviedb.org/3/")!
    }

    var method: HTTPMethod{
        switch self {
        case .nowPlaying, .upcoming, .similar, .detail, .search:
            return .get
        }
    }
    
    var parameters: [String: Any]?{
        var params: Parameters = [:]
        switch self {
        case .nowPlaying:
            return nil
        case .upcoming:
            return nil
        case .similar(let movieId):
            if let movieId = movieId {
                params["movieId"] = movieId
            }
        case .detail(let movieId):
            if let movieId = movieId {
                params["movieId"] = movieId
            }
        case .search(let query):
            if let query = query {
                params["query"] = query
            }
        }
        return params
    }
    
    var encoding: ParameterEncoding{
        return JSONEncoding.default
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        case .upcoming:
            return "movie/upcoming"
        case .similar(let movieId):
            if let movieId = movieId {
               return "movie/\(movieId)/similar"
            } else {
                return ""
            }
        case .detail(let movieId):
            if let movieId = movieId {
                return "movie/\(movieId)"
            }else {
                return ""
            }
        case .search(_):
                return "search/movie"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method{
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var completeParameters = parameters ?? [:]
        
        completeParameters["api_key"] = ServiceRouter.api_key
        
        //let urlReq = try encoding.encode(urlRequest, with: completeParameters)
        return try encoding.encode(urlRequest, with: completeParameters)
    }
}

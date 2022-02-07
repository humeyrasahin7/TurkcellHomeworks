//
//  User.swift
//  SearchbarHomework
//
//  Created by Hümeyra Şahin on 7.02.2022.
//

import Foundation

struct User: Decodable {
    
    let username: String
    let email: String
    let company: Company
}

struct Company: Decodable {
    let name: String
}

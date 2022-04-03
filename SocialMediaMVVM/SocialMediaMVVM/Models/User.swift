//
//  User.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 3.04.2022.
//

import Foundation

public struct User: Decodable{
    public let id: Int?
    public let name: String?
    public let username: String?
    public let email: String?
}

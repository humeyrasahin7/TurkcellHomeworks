//
//  Comment.swift
//  SocialMediaMVVM
//
//  Created by Hümeyra Şahin on 3.04.2022.
//

import Foundation

public struct Comment: Decodable{
    public let postId: Int?
    public let name: String?
    public let email: String?
    public let body: String?
}

//
//  MarvelClass.swift
//  Marvel
//
//  Created by Bruno Silva on 22/12/20.
//

import Foundation

struct MarvelInfo: Codable {
    let code: Int
    let status: String
    let data: MarvelData
}

struct MarvelData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Hero]
}

struct Hero: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let urls: [HeroURL]
}

struct Thumbnail: Codable {
    let path: String
    let ex: String
    
    var url: String {
        return path + "." + ex
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ex = "extension"
    }
}

struct HeroURL: Codable {
    let type: String
    let url: String
}

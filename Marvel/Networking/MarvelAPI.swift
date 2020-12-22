//
//  MarvelAPI.swift
//  Marvel
//
//  Created by Bruno Silva on 22/12/20.
//

import Foundation
import Alamofire
import SwiftHash

class MarvelAPI {
    
    //https://gateway.marvel.com:443/v1/public/characters?apikey=95f784d1ede496307f1ce79af222571f
    
    //MARK: - Variables
    static private let basePath = "http://gateway.marvel.com/v1/public/characters?"
    static private let privateKey = "39dc3acbe6b441db421bb6e7bfbd21696fda7817"
    static private let publicKey = "95f784d1ede496307f1ce79af222571f"
    static private let limit = 50
    
    //MARK: - Functions
    class func loadHeroes(page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void) {
        let offset = page * limit
        let url = basePath + "offset=\(offset)&limit=\(limit)&" + getCredentials()
        print(url)
        AF.request(url).responseJSON { (response) in
            guard let data = response.data else { return }
            guard let marvelInfo = try? JSONDecoder().decode(MarvelInfo.self, from: data) else {
                print("Não conseguimos converter o JSON 😭")
                return
            }
            if marvelInfo.code == 200 {
                onComplete(marvelInfo)
            } else {
                print("Aconteceu alguma coisa.. 😭")
            }
        }
    }
    
    private class func getCredentials() -> String {
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(timestamp+privateKey+publicKey).lowercased()
        return "ts=\(timestamp)&apikey=\(publicKey)4&hash=\(hash)"
    }
}

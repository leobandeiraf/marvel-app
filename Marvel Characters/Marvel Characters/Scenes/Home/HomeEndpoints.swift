//
//  HomeEndpoints.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import Foundation

enum HomeEndpoints {
    case characters
    
    var path: String {
        switch self {
        case .characters:
            return "https://gateway.marvel.com:443/v1/public/characters"
        }
    }
}

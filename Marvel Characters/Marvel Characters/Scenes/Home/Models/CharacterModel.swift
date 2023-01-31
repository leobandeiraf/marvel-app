//
//  CharacterModel.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import Foundation

struct Character: Decodable {
    let name: String?
    let description: String?
    let thumbnail: CharacterImage?
    
    struct CharacterImage: Decodable {
        let path: String?
        let url: String?
    }
}

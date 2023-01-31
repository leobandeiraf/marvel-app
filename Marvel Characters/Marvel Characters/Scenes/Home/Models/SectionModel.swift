//
//  SectionModel.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 31/01/23.
//

import Foundation

struct SectionModel {
    let section: Section
    let characters: [Character]?
    
    var numberOfRows: Int {
        characters?.count ?? 0
    }
    
    enum Section {
        case carousel, list
    }
}

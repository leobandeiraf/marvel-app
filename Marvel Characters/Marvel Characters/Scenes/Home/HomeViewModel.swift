//
//  HomeViewModel.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import Foundation

protocol HomeViewModeling: AnyObject {
    func getCharacters()
}

final class HomeViewModel: HomeViewModeling {
    // MARK: Property(ies).
    let service: HomeServicing
    var characters = [Character]()
    
    // MARK: - Initialization(s).
    init(service: HomeServicing) {
        self.service = service
    }
    
    // MARK: - Method(s).
    func getCharacters() {
        service.getCharacters { [weak self] result in
            switch result {
            case let .success(model):
                self?.characters = model
            case .failure:
                break
            }
        }
    }
}

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
    private let service: HomeServicing
    weak var viewController: HomeDisplaying?
    
    // MARK: - Initialization(s).
    init(service: HomeServicing) {
        self.service = service
    }
    
    // MARK: - Method(s).
    func getCharacters() {
        service.getCharacters { [weak self] result in
            switch result {
            case let .success(model):
                self?.viewController?.displayCharacters(with: model)
            case let .failure(error):
                print(error)
            }
        }
    }
}

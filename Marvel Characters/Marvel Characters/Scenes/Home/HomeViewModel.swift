//
//  HomeViewModel.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import Foundation

protocol HomeViewModeling: AnyObject {
    func getCharacters()
    func getMoreCharacters()
}

final class HomeViewModel: HomeViewModeling {
    // MARK: Property(ies).
    private let service: HomeServicing
    weak var viewController: HomeDisplaying?
    
    private var limit: Int = 25
    private var offset: Int = 0
    
    // MARK: - Initialization(s).
    init(service: HomeServicing) {
        self.service = service
    }
    
    // MARK: - Method(s).
    func getCharacters() {
        performLoading(true)
        service.getCharacters(limit: self.limit) { [weak self] result in
            self?.performLoading(false)
            switch result {
            case let .success(model):
                self?.buildSections(with: model)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getMoreCharacters() {
        offset += 25
        getCharacters()
    }
    
    func buildSections(with model: [Character]?) {
        var carouselModel = [Character]()
        var listModel = [Character]()
        
        model?.enumerated().forEach {
            $0.offset < 5 ? carouselModel.append($0.element) : listModel.append($0.element)
        }
        
        viewController?.displayCharacters(with: [
            SectionModel(section: .carousel, characters: carouselModel),
            SectionModel(section: .list, characters: listModel)
        ])
    }
    
    func performLoading(_ bool: Bool) {
        viewController?.displayLoading(bool)
    }
}

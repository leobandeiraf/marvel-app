//
//  HomeFactory.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import Foundation

final class HomeFactory {
    static func make() -> HomeViewController {
        let service = HomeService()
        let viewModel = HomeViewModel(service: service)
        
        return HomeViewController(viewModel: viewModel)
    }
}

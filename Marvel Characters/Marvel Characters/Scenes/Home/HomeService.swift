//
//  HomeService.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import Alamofire
import Foundation

protocol HomeServicing: AnyObject {
    func getCharacters(completion: @escaping (Result<[Character], AFError>) -> Void)
}

final class HomeService: HomeServicing {
    func getCharacters(completion: @escaping (Result<[Character], AFError>) -> Void) {
        AF.request(HomeEndpoints.characters.path).responseDecodable(of: CharacterWrapperModel.self) { response in
            completion(response.result.map(\.data.results))
        }
    }
}

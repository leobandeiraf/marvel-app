//
//  HomeService.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import Alamofire
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

protocol HomeServicing: AnyObject {
    func getCharacters(completion: @escaping (Result<[Character]?, AFError>) -> Void)
}

final class HomeService {
    // MARK: - Property(ies).
}

// MARK: - HomeServicing Method(s).
extension HomeService: HomeServicing {
    func getCharacters(completion: @escaping (Result<[Character]?, AFError>) -> Void) {
        AF.request(MarvelAPI.Endpoint.characters.path).responseDecodable(of: CharacterWrapperModel.self) { response in
            completion(response.result.map(\.data?.results))
        }
    }
}

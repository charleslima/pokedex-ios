//
//  PokemonRemoteDataSource.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import Foundation

protocol PokemonRemoteDataSource {
    func getPokemonTypes(completion: @escaping (Result<[PokemonTypeDTO], Error>) -> Void)
}

enum PokemonRemoteDataSourceError: LocalizedError {
    
    case http(Int)
    case mapping
    
    var errorDescription: String? {
        switch self {
        case .http(let statusCode):
            return "error statusCode: \(statusCode)"
        default:
            return nil
        }
    }
}

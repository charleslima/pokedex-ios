//
//  PokemonRepositoryImpl.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

final class PokemonRepositoryImpl: PokemonRepository {
    
    private let pokemonRemoteDataSource: PokemonRemoteDataSource
    
    init(pokemonRemoteDataSource: PokemonRemoteDataSource) {
        self.pokemonRemoteDataSource = pokemonRemoteDataSource
    }
    
    func getPokemonsBy(typeID: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        pokemonRemoteDataSource.getPokemonsBy(typeID: typeID) { (result) in
            switch result {
            case .success(let pokemonsDTOs):
                completion(.success(pokemonsDTOs.map({ Pokemon(name: $0.name) })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

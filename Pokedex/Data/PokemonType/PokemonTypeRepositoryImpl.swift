//
//  PokemonTypeRepositoryImpl.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

final class PokemonTypeRepositoryImpl: PokemonTypeRepository {
    
    private let pokemonRemoteDataSource: PokemonRemoteDataSource
    
    init(pokemonRemoteDataSource: PokemonRemoteDataSource) {
        self.pokemonRemoteDataSource = pokemonRemoteDataSource
    }
    
    func getPokemonTypes(completion: @escaping (Result<[PokemonType], Error>) -> Void) {
        self.pokemonRemoteDataSource.getPokemonTypes { (result) in
            switch result {
            case .success(let pokemonDTOs):
                completion(.success(pokemonDTOs.map({ PokemonType(name: $0.name) })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

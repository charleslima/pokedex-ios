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
            case .success(let pokemonTypesDTOs):
                completion(.success(
                            pokemonTypesDTOs.compactMap({ self.mapPokemonType(from: $0) }))
                )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func mapPokemonType(from pokemonTypeDTO: PokemonTypeDTO) -> PokemonType? {
        return PokemonType(id: pokemonTypeDTO.id, name: pokemonTypeDTO.name)
    }
}

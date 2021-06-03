//
//  GetPokemonTypesUseCaseImpl.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

final class GetPokemonTypesUseCaseImpl: GetPokemonTypesUseCase {
    
    let pokemonTypesRepository: PokemonTypesRepository
    
    init(pokemonTypesRepository: PokemonTypesRepository) {
        self.pokemonTypesRepository = pokemonTypesRepository
    }
    
    func getPokemonTypes(completion: @escaping (Result<[PokemonType], Error>) -> Void) {
        self.pokemonTypesRepository.getPokemonTypes(completion: completion)
    }
}

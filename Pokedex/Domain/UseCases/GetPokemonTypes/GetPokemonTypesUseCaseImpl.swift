//
//  GetPokemonTypesUseCaseImpl.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

final class GetPokemonTypesUseCaseImpl: GetPokemonTypesUseCase {
    
    let pokemonTypeRepository: PokemonTypeRepository
    
    init(pokemonTypeRepository: PokemonTypeRepository) {
        self.pokemonTypeRepository = pokemonTypeRepository
    }
    
    func getPokemonTypes(completion: @escaping (Result<[PokemonType], Error>) -> Void) {
        self.pokemonTypeRepository.getPokemonTypes(completion: completion)
    }
}

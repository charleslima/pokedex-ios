//
//  GetPokemonsUseCaseImpl.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

final class GetPokemonsUseCaseImpl: GetPokemonsUseCase {
    
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    func getPokemonsBy(typeID: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        pokemonRepository.getPokemonsBy(typeID: typeID, completion: completion)
    }
}

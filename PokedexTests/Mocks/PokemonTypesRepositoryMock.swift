//
//  PokemonTypesRepositoryMock.swift
//  PokedexTests
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

@testable import Pokedex

final class PokemonTypesRepositoryMock: PokemonTypeRepository {
    
    let result: Result<[PokemonType], Error>
    
    init(result: Result<[PokemonType], Error>) {
        self.result = result
    }
    
    func getPokemonTypes(completion: @escaping (Result<[PokemonType], Error>) -> Void) {
        completion(result)
    }
}

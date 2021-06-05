//
//  PokemonRepositoryMock.swift
//  PokedexTests
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

@testable import Pokedex

final class PokemonRepositoryMock: PokemonRepository {
    
    let result: Result<[Pokemon], Error>
    
    init(result: Result<[Pokemon], Error>) {
        self.result = result
    }
    
    func getPokemonsBy(typeID: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        completion(result)
    }
}

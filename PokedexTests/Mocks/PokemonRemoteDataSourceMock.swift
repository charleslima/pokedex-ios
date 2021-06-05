//
//  PokemonRemoteDataSourceMock.swift
//  PokedexTests
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

@testable import Pokedex

final class PokemonRemoteDataSourceMock: PokemonRemoteDataSource {
    
    let getPokemonTypesResult: Result<[PokemonTypeDTO], Error>
    let getPokemonsByTypeResult: Result<[PokemonDTO], Error>
    
    init(getPokemonTypesResult: Result<[PokemonTypeDTO], Error> = .success([]),
         getPokemonsByTypeResult: Result<[PokemonDTO], Error> = .success([])) {
        self.getPokemonTypesResult = getPokemonTypesResult
        self.getPokemonsByTypeResult = getPokemonsByTypeResult
    }
    
    func getPokemonTypes(completion: @escaping (Result<[PokemonTypeDTO], Error>) -> Void) {
        completion(getPokemonTypesResult)
    }
    
    func getPokemonsBy(typeID: Int, completion: @escaping (Result<[PokemonDTO], Error>) -> Void) {
        completion(getPokemonsByTypeResult)
    }
}

//
//  PokemonTypesRepository.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

protocol PokemonTypesRepository {
    func getPokemonTypes(completion: @escaping (Result<[PokemonType], Error>) -> Void)
}

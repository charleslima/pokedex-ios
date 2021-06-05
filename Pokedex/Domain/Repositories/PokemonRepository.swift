//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

protocol PokemonRepository {
    func getPokemonsBy(typeID: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

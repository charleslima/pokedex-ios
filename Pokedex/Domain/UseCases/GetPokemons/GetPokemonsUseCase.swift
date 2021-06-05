//
//  GetPokemonsUseCase.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

protocol GetPokemonsUseCase {
    func getPokemonsBy(typeID: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

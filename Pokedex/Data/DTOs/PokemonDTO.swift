//
//  PokemonDTO.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

class PokemonDTO: Decodable {
    
    class Specy: Decodable {
        let color: Color
        class Color: Decodable {
            let name: String
        }
    }
    
    let id: Int
    let name: String
    let specy: Specy
    
}

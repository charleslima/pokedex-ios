//
//  Pokemon.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

final class Pokemon {
    
    let name: String
    let imageURL: String
    let colorName: String
    
    init(name: String,
         imageURL: String,
         colorName: String) {
        self.name = name
        self.imageURL = imageURL
        self.colorName = colorName
    }
    
}

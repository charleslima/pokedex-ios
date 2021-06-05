//
//  PokemonsViewModel.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

final class PokemonsViewModel {
    
    private let getPokemonsUseCase: GetPokemonsUseCase
    
    var pokemons: [Pokemon] = []
    var didGetPokemons: (() -> Void)?
    var didGetError: (() -> Void)?
    
    init(getPokemonsUseCase: GetPokemonsUseCase) {
        self.getPokemonsUseCase = getPokemonsUseCase
    }
    
    func getPokemonsBy(typeID: Int) {
        self.getPokemonsUseCase.getPokemonsBy(typeID: typeID, completion: { [weak self] result in
            switch result {
            case .success(let pokemons):
                self?.pokemons = pokemons
                self?.didGetPokemons?()
            case .failure:
                self?.didGetError?()
            }
        })
    }
}

//
//  PokemonTypesViewModel.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

final class PokemonTypesViewModel {
    
    private let getPokemonTypesUseCase: GetPokemonTypesUseCase
    
    var pokemonTypes: [PokemonType] = []
    var didGetPokemonTypes: (() -> Void)?
    var didGetError: (() -> Void)?
    
    init(getPokemonTypesUseCase: GetPokemonTypesUseCase) {
        self.getPokemonTypesUseCase = getPokemonTypesUseCase
    }
    
    func getPokemonTypes() {
        self.getPokemonTypesUseCase.getPokemonTypes(completion: { [weak self] result in
            switch result {
            case .success(let pokemonTypes):
                self?.pokemonTypes = pokemonTypes
                self?.didGetPokemonTypes?()
            case .failure:
                self?.didGetError?()
            }
        })
    }
}

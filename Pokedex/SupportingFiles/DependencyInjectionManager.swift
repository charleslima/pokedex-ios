//
//  DependencyInjectionManager.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import Swinject

final class DependencyInjectionManager {
    
    let container: Container = Container()
    
    init() {
        registerViews()
    }
    
    private func registerViews() {
        container.register(PokemonTypesView.self) { _ in
            PokemonTypesView()
        }
    }
    
}

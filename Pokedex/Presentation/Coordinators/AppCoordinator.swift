//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import Swinject

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow?
    private let container: Container
    
    init(window: UIWindow?,
         container: Container) {
        self.window = window
        self.container = container
    }
    
    func start() {
        let pokemonTypesView = container.resolve(PokemonTypesView.self)!
        self.window?.rootViewController = pokemonTypesView
    }
}

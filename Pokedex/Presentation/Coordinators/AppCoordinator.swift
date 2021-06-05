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
    private var pokemonsCoordinator: PokemonsCoordinator?
    
    
    init(window: UIWindow?,
         container: Container) {
        self.window = window
        self.container = container
    }
    
    func start() {
        self.pokemonsCoordinator = PokemonsCoordinator(window: window, container: container)
        self.pokemonsCoordinator?.start()
    }
}

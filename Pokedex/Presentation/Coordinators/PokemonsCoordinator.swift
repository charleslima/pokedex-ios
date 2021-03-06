//
//  PokemonsCoordinator.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import Swinject

final class PokemonsCoordinator: Coordinator {
    
    private let window: UIWindow?
    private let container: Container
    private var navigationController: UINavigationController?
    
    init(window: UIWindow?,
         container: Container) {
        self.window = window
        self.container = container
    }
    
    func start() {
        let pokemonTypesView = container.resolve(PokemonTypesView.self)!
        pokemonTypesView.delegate = self
        self.navigationController = UINavigationController(rootViewController: pokemonTypesView)
        self.window?.rootViewController = navigationController
    }
    
    private func showPokemonsView(type: PokemonType) {
        let pokemonsView = container.resolve(PokemonsView.self, argument: type)!
        self.navigationController?.pushViewController(pokemonsView, animated: true)
    }
}

extension PokemonsCoordinator: PokemonTypesViewDelegate {
    
    func userDidTapPokemonType(type: PokemonType) {
        self.showPokemonsView(type: type)
    }
    
}

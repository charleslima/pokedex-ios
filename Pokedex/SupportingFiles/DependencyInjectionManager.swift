//
//  DependencyInjectionManager.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import Swinject
import Moya

final class DependencyInjectionManager {
    
    let container: Container = Container()
    
    init() {
        registerScreens()
        registerViews()
        registerViewModels()
        registerUseCases()
        registerRepositories()
        registerDataSources()
    }
    
    private func registerScreens() {
        self.container.register(PokemonTypesScreen.self) { _ in 
            return PokemonTypesScreen()
        }
        
        self.container.register(PokemonsScreen.self) { (_, type: PokemonType) in
            return PokemonsScreen(type: type)
        }
    }
    
    private func registerViews() {
        self.container.register(PokemonTypesView.self) { resolver in
            return PokemonTypesView(screen: resolver.resolve(PokemonTypesScreen.self)!,
                                    viewModel: resolver.resolve(PokemonTypesViewModel.self)!)
        }
        
        self.container.register(PokemonsView.self) { (resolver, type: PokemonType) in
            return PokemonsView(screen: resolver.resolve(PokemonsScreen.self, argument: type)!,
                                viewModel: resolver.resolve(PokemonsViewModel.self)!,
                                type: type)
        }
    }
    
    private func registerViewModels() {
        self.container.register(PokemonTypesViewModel.self) { resolver in
            PokemonTypesViewModel(getPokemonTypesUseCase: resolver.resolve(
                                    GetPokemonTypesUseCase.self)!
            )
        }
        
        self.container.register(PokemonsViewModel.self) { resolver in
            PokemonsViewModel(getPokemonsUseCase: resolver.resolve(
                                GetPokemonsUseCase.self)!
            )
        }
    }
    
    private func registerUseCases() {
        self.container.register(GetPokemonTypesUseCase.self) { resolver in
            GetPokemonTypesUseCaseImpl(
                pokemonTypeRepository: resolver.resolve(PokemonTypeRepository.self)!
            )
        }
        
        self.container.register(GetPokemonsUseCase.self) { resolver in
            GetPokemonsUseCaseImpl(
                pokemonRepository: resolver.resolve(PokemonRepository.self)!
            )
        }
    }
    
    private func registerRepositories() {
        self.container.register(PokemonTypeRepository.self) { resolver in
            PokemonTypeRepositoryImpl(
                pokemonRemoteDataSource: resolver.resolve(PokemonRemoteDataSource.self)!
            )
        }
        
        self.container.register(PokemonRepository.self) { resolver in
            PokemonRepositoryImpl(
                pokemonRemoteDataSource: resolver.resolve(PokemonRemoteDataSource.self)!
            )
        }
    }
    
    private func registerDataSources() {
        self.container.register(PokemonRemoteDataSource.self) { resolver in
            let provider = MoyaProvider<PokemonAPI>(plugins: [NetworkLoggerPlugin()])
            
            return PokemonRemoteDataSourceImpl(provider: provider)
        }
    }
    
}

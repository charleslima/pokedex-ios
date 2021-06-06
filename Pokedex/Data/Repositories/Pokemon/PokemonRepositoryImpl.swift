//
//  PokemonRepositoryImpl.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

final class PokemonRepositoryImpl: PokemonRepository {
    
    private let pokemonRemoteDataSource: PokemonRemoteDataSource
    
    init(pokemonRemoteDataSource: PokemonRemoteDataSource) {
        self.pokemonRemoteDataSource = pokemonRemoteDataSource
    }
    
    func getPokemonsBy(typeID: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        pokemonRemoteDataSource.getPokemonsBy(typeID: typeID) { (result) in
            switch result {
            case .success(let pokemonsDTOs):
                completion(.success(pokemonsDTOs.compactMap({ self.mapPokemon(from: $0) })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func mapPokemon(from PokemonDTO: PokemonDTO) -> Pokemon? {
        guard let idString = try? PokemonDTO.url.asURL().lastPathComponent else { return nil }
        
        let imageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idString).png"
        
        return Pokemon(name: PokemonDTO.name,
                       imageURL: imageURL)
    }
}

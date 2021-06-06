//
//  PokemonRemoteDataSourceImpl.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import Moya

final class PokemonRemoteDataSourceImpl: PokemonRemoteDataSource {
    
    let provider: MoyaProvider<PokemonAPI>
    
    init(provider: MoyaProvider<PokemonAPI>) {
        self.provider = provider
    }
    
    func getPokemonTypes(completion: @escaping (Result<[PokemonTypeDTO], Error>) -> Void) {
        provider.request(.getPokemonTypes) { (response) in
            switch response {
            case .success(let result):
                if 200...299 ~= result.statusCode {
                    do {
                        let pokemonTypeDTOs = try result.map([PokemonTypeDTO].self, atKeyPath: "data.types")
                        completion(.success(pokemonTypeDTOs))
                    } catch {
                        completion(.failure(PokemonRemoteDataSourceError.mapping))
                    }
                } else {
                    completion(.failure(PokemonRemoteDataSourceError.http(result.statusCode)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPokemonsBy(typeID: Int, completion: @escaping (Result<[PokemonDTO], Error>) -> Void) {
        provider.request(.getPokemonsByType(id: typeID)) { (response) in
            switch response {
            case .success(let result):
                if 200...299 ~= result.statusCode {
                    do {
                        let pokemons = try result.map([PokemonDTO].self, atKeyPath: "data.pokemons")
                        completion(.success(pokemons))
                    } catch {
                        completion(.failure(PokemonRemoteDataSourceError.mapping))
                    }
                } else {
                    completion(.failure(PokemonRemoteDataSourceError.http(result.statusCode)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
